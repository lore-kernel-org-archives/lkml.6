Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeBLFIu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:08:50 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37964 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeBLFIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:08:48 -0500
X-Google-Smtp-Source: AH8x226coBTJcc2ITnI5BtktJ2bH7i10Bd7G2ok0gC5yBN+jXVwwA8BEDB6TrBJ3JptQ6CUjfwZO4GT0PYMVC+6gZxk=
MIME-Version: 1.0
From: "Md. Islam" <mislam4@kent.edu>
Date: Mon, 12 Feb 2018 00:08:46 -0500
Message-ID: <CAFgPn1C0Yc+QDkA3szkYgRXqK6PWDDJE1fGhJkfYM-hXR3ABQg@mail.gmail.com>
Subject: [PATCH net-next] trace_events_filter: conditional trace event
 (tcp_probe full=0)
To: tom.zanussi@linux.intel.com, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, mathieu.desnoyers@polymtl.ca
Content-Type: multipart/mixed; boundary="94eb2c0956107622970564fcdfe7"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--94eb2c0956107622970564fcdfe7
Content-Type: text/plain; charset="UTF-8"

Recently tcp_probe kernel module has been replaced by trace_event. Old
tcp_probe had full=0 option where it only takes a snapshot only when
congestion window is changed. However I did not find such
functionality in trace_event. This is why I implemented this
"conditional trace_event" where a snapshot is taken only if some field
is changed. For instance, following filter will record a snapshot only
if snd_cwnd field is changed from the previous snapshot:

cd /sys/kernel/debug/tracing
echo 1 > events/tcp/tcp_probe/enable
echo "(sport == 8554 && snd_cwnd =< 0)"  > events/tcp/tcp_probe/filter &
cat trace_pipe > /home/tamim/net-next/trace.data

This will record a snapshot where source port is 8554 and snd_cwnd is
not same as the snd_cwnd in previous snapshot. For lack of better
operator, I used "=<" to represent the field on which the filter will
be applied.

The way it works is, it updates the predicate with new value every
time. So the next time, if the field is same as in the predicate, the
snapshot is ignored. Initially it checks if  the field is 0 or not.

diff --git a/kernel/trace/trace_events_filter.c
b/kernel/trace/trace_events_filter.c
index 61e7f06..8d733fa 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -39,6 +39,7 @@ enum filter_op_ids
     OP_AND,
     OP_GLOB,
     OP_NE,
+        OP_NE_PREV,
     OP_EQ,
     OP_LT,
     OP_LE,
@@ -62,6 +63,7 @@ static struct filter_op filter_ops[] = {
     { OP_AND,    "&&",        2 },
     { OP_GLOB,    "~",        4 },
     { OP_NE,    "!=",        4 },
+    { OP_NE_PREV,   "=<",        4 },
     { OP_EQ,    "==",        4 },
     { OP_LT,    "<",        5 },
     { OP_LE,    "<=",        5 },
@@ -202,6 +204,21 @@ static int filter_pred_##size(struct filter_pred
*pred, void *event)    \
     return match;                            \
 }

+#define DEFINE_NE_PREV_PRED(size)                    \
+static int filter_ne_prev_pred_##size(struct filter_pred *pred, void
*event)    \
+{                                    \
+    u##size *addr = (u##size *)(event + pred->offset);        \
+    u##size val = (u##size)pred->val;                \
+    int match;                                                      \
+                                    \
+    match = (val == *addr) ^ pred->not;                \
+                                                                        \
+        if(match == 1)                                                  \
+                pred->val = *addr;                                      \
+    return match;                            \
+}
+
+
 DEFINE_COMPARISON_PRED(s64);
 DEFINE_COMPARISON_PRED(u64);
 DEFINE_COMPARISON_PRED(s32);
@@ -216,6 +233,11 @@ DEFINE_EQUALITY_PRED(32);
 DEFINE_EQUALITY_PRED(16);
 DEFINE_EQUALITY_PRED(8);

+DEFINE_NE_PREV_PRED(64);
+DEFINE_NE_PREV_PRED(32);
+DEFINE_NE_PREV_PRED(16);
+DEFINE_NE_PREV_PRED(8);
+
 /* Filter predicate for fixed sized arrays of characters */
 static int filter_pred_string(struct filter_pred *pred, void *event)
 {
@@ -980,7 +1002,7 @@ int filter_assign_type(const char *type)
 static bool is_legal_op(struct ftrace_event_field *field, enum
filter_op_ids op)
 {
     if (is_string_field(field) &&
-        (op != OP_EQ && op != OP_NE && op != OP_GLOB))
+        (op != OP_EQ && op != OP_NE && op != OP_GLOB && op != OP_NE_PREV))
         return false;
     if (!is_string_field(field) && op == OP_GLOB)
         return false;
@@ -997,6 +1019,8 @@ static filter_pred_fn_t select_comparison_fn(enum
filter_op_ids op,
     case 8:
         if (op == OP_EQ || op == OP_NE)
             fn = filter_pred_64;
+                else if (op == OP_NE_PREV)
+            fn = filter_ne_prev_pred_64;
         else if (field_is_signed)
             fn = pred_funcs_s64[op - PRED_FUNC_START];
         else
@@ -1005,6 +1029,8 @@ static filter_pred_fn_t
select_comparison_fn(enum filter_op_ids op,
     case 4:
         if (op == OP_EQ || op == OP_NE)
             fn = filter_pred_32;
+                else if (op == OP_NE_PREV)
+            fn = filter_ne_prev_pred_32;
         else if (field_is_signed)
             fn = pred_funcs_s32[op - PRED_FUNC_START];
         else
@@ -1013,6 +1039,8 @@ static filter_pred_fn_t
select_comparison_fn(enum filter_op_ids op,
     case 2:
         if (op == OP_EQ || op == OP_NE)
             fn = filter_pred_16;
+                else if (op == OP_NE_PREV)
+            fn = filter_ne_prev_pred_16;
         else if (field_is_signed)
             fn = pred_funcs_s16[op - PRED_FUNC_START];
         else
@@ -1021,6 +1049,8 @@ static filter_pred_fn_t
select_comparison_fn(enum filter_op_ids op,
     case 1:
         if (op == OP_EQ || op == OP_NE)
             fn = filter_pred_8;
+                else if (op == OP_NE_PREV)
+            fn = filter_ne_prev_pred_8;
         else if (field_is_signed)
             fn = pred_funcs_s8[op - PRED_FUNC_START];
         else
@@ -1088,7 +1118,7 @@ static int init_pred(struct filter_parse_state *ps,
         }
     }

-    if (pred->op == OP_NE)
+    if (pred->op == OP_NE || pred->op == OP_NE_PREV)
         pred->not ^= 1;

     pred->fn = fn;
@@ -2197,7 +2227,7 @@ static int ftrace_function_check_pred(struct
filter_pred *pred, int leaf)
          *  - only '==' and '!=' is used
          *  - the 'ip' field is used
          */
-        if ((pred->op != OP_EQ) && (pred->op != OP_NE))
+        if ((pred->op != OP_EQ) && (pred->op != OP_NE) && (pred->op
!= OP_NE_PREV))
             return -EINVAL;

         if (strcmp(field->name, "ip"))


I'm new to upstream kernel development. Please let me any suggestion.

Many thanks
Tamim
PhD Candidate,
Kent State University

--94eb2c0956107622970564fcdfe7
Content-Type: text/x-patch; charset="US-ASCII"; name="conditional_traceevent.patch"
Content-Disposition: attachment; filename="conditional_traceevent.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jdjqvjm90

ZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfZmlsdGVyLmMgYi9rZXJuZWwv
dHJhY2UvdHJhY2VfZXZlbnRzX2ZpbHRlci5jCmluZGV4IDYxZTdmMDYuLjhkNzMzZmEgMTAwNjQ0
Ci0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfZmlsdGVyLmMKKysrIGIva2VybmVsL3Ry
YWNlL3RyYWNlX2V2ZW50c19maWx0ZXIuYwpAQCAtMzksNiArMzksNyBAQCBlbnVtIGZpbHRlcl9v
cF9pZHMKIAlPUF9BTkQsCiAJT1BfR0xPQiwKIAlPUF9ORSwKKyAgICAgICAgT1BfTkVfUFJFViwg
ICAgICAgIAogCU9QX0VRLAogCU9QX0xULAogCU9QX0xFLApAQCAtNjIsNiArNjMsNyBAQCBzdGF0
aWMgc3RydWN0IGZpbHRlcl9vcCBmaWx0ZXJfb3BzW10gPSB7CiAJeyBPUF9BTkQsCSImJiIsCQky
IH0sCiAJeyBPUF9HTE9CLAkifiIsCQk0IH0sCiAJeyBPUF9ORSwJIiE9IiwJCTQgfSwKKwl7IE9Q
X05FX1BSRVYsICAgIj08IiwJCTQgfSwgICAgICAgIAogCXsgT1BfRVEsCSI9PSIsCQk0IH0sCiAJ
eyBPUF9MVCwJIjwiLAkJNSB9LAogCXsgT1BfTEUsCSI8PSIsCQk1IH0sCkBAIC0yMDIsNiArMjA0
LDIxIEBAIHN0YXRpYyBpbnQgZmlsdGVyX3ByZWRfIyNzaXplKHN0cnVjdCBmaWx0ZXJfcHJlZCAq
cHJlZCwgdm9pZCAqZXZlbnQpCVwKIAlyZXR1cm4gbWF0Y2g7CQkJCQkJCVwKIH0KIAorI2RlZmlu
ZSBERUZJTkVfTkVfUFJFVl9QUkVEKHNpemUpCQkJCQlcCitzdGF0aWMgaW50IGZpbHRlcl9uZV9w
cmV2X3ByZWRfIyNzaXplKHN0cnVjdCBmaWx0ZXJfcHJlZCAqcHJlZCwgdm9pZCAqZXZlbnQpCVwK
K3sJCQkJCQkJCQlcCisJdSMjc2l6ZSAqYWRkciA9ICh1IyNzaXplICopKGV2ZW50ICsgcHJlZC0+
b2Zmc2V0KTsJCVwKKwl1IyNzaXplIHZhbCA9ICh1IyNzaXplKXByZWQtPnZhbDsJCQkJXAorCWlu
dCBtYXRjaDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcCisJCQkJCQkJCQlcCisJbWF0Y2ggPSAodmFsID09ICphZGRyKSBeIHByZWQtPm5vdDsJ
CQkJXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICBpZihtYXRjaCA9PSAxKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICAgICAgICAg
IHByZWQtPnZhbCA9ICphZGRyOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAorCXJldHVybiBtYXRjaDsJCQkJCQkJXAorfQorCisKIERFRklORV9DT01QQVJJU09OX1BSRUQo
czY0KTsKIERFRklORV9DT01QQVJJU09OX1BSRUQodTY0KTsKIERFRklORV9DT01QQVJJU09OX1BS
RUQoczMyKTsKQEAgLTIxNiw2ICsyMzMsMTEgQEAgREVGSU5FX0VRVUFMSVRZX1BSRUQoMzIpOwog
REVGSU5FX0VRVUFMSVRZX1BSRUQoMTYpOwogREVGSU5FX0VRVUFMSVRZX1BSRUQoOCk7CiAKK0RF
RklORV9ORV9QUkVWX1BSRUQoNjQpOworREVGSU5FX05FX1BSRVZfUFJFRCgzMik7CitERUZJTkVf
TkVfUFJFVl9QUkVEKDE2KTsKK0RFRklORV9ORV9QUkVWX1BSRUQoOCk7CisKIC8qIEZpbHRlciBw
cmVkaWNhdGUgZm9yIGZpeGVkIHNpemVkIGFycmF5cyBvZiBjaGFyYWN0ZXJzICovCiBzdGF0aWMg
aW50IGZpbHRlcl9wcmVkX3N0cmluZyhzdHJ1Y3QgZmlsdGVyX3ByZWQgKnByZWQsIHZvaWQgKmV2
ZW50KQogewpAQCAtOTgwLDcgKzEwMDIsNyBAQCBpbnQgZmlsdGVyX2Fzc2lnbl90eXBlKGNvbnN0
IGNoYXIgKnR5cGUpCiBzdGF0aWMgYm9vbCBpc19sZWdhbF9vcChzdHJ1Y3QgZnRyYWNlX2V2ZW50
X2ZpZWxkICpmaWVsZCwgZW51bSBmaWx0ZXJfb3BfaWRzIG9wKQogewogCWlmIChpc19zdHJpbmdf
ZmllbGQoZmllbGQpICYmCi0JICAgIChvcCAhPSBPUF9FUSAmJiBvcCAhPSBPUF9ORSAmJiBvcCAh
PSBPUF9HTE9CKSkKKwkgICAgKG9wICE9IE9QX0VRICYmIG9wICE9IE9QX05FICYmIG9wICE9IE9Q
X0dMT0IgJiYgb3AgIT0gT1BfTkVfUFJFVikpCiAJCXJldHVybiBmYWxzZTsKIAlpZiAoIWlzX3N0
cmluZ19maWVsZChmaWVsZCkgJiYgb3AgPT0gT1BfR0xPQikKIAkJcmV0dXJuIGZhbHNlOwpAQCAt
OTk3LDYgKzEwMTksOCBAQCBzdGF0aWMgZmlsdGVyX3ByZWRfZm5fdCBzZWxlY3RfY29tcGFyaXNv
bl9mbihlbnVtIGZpbHRlcl9vcF9pZHMgb3AsCiAJY2FzZSA4OgogCQlpZiAob3AgPT0gT1BfRVEg
fHwgb3AgPT0gT1BfTkUpCiAJCQlmbiA9IGZpbHRlcl9wcmVkXzY0OworICAgICAgICAgICAgICAg
IGVsc2UgaWYgKG9wID09IE9QX05FX1BSRVYpCisJCQlmbiA9IGZpbHRlcl9uZV9wcmV2X3ByZWRf
NjQ7CiAJCWVsc2UgaWYgKGZpZWxkX2lzX3NpZ25lZCkKIAkJCWZuID0gcHJlZF9mdW5jc19zNjRb
b3AgLSBQUkVEX0ZVTkNfU1RBUlRdOwogCQllbHNlCkBAIC0xMDA1LDYgKzEwMjksOCBAQCBzdGF0
aWMgZmlsdGVyX3ByZWRfZm5fdCBzZWxlY3RfY29tcGFyaXNvbl9mbihlbnVtIGZpbHRlcl9vcF9p
ZHMgb3AsCiAJY2FzZSA0OgogCQlpZiAob3AgPT0gT1BfRVEgfHwgb3AgPT0gT1BfTkUpCiAJCQlm
biA9IGZpbHRlcl9wcmVkXzMyOworICAgICAgICAgICAgICAgIGVsc2UgaWYgKG9wID09IE9QX05F
X1BSRVYpCisJCQlmbiA9IGZpbHRlcl9uZV9wcmV2X3ByZWRfMzI7ICAgICAgICAgICAgICAgIAog
CQllbHNlIGlmIChmaWVsZF9pc19zaWduZWQpCiAJCQlmbiA9IHByZWRfZnVuY3NfczMyW29wIC0g
UFJFRF9GVU5DX1NUQVJUXTsKIAkJZWxzZQpAQCAtMTAxMyw2ICsxMDM5LDggQEAgc3RhdGljIGZp
bHRlcl9wcmVkX2ZuX3Qgc2VsZWN0X2NvbXBhcmlzb25fZm4oZW51bSBmaWx0ZXJfb3BfaWRzIG9w
LAogCWNhc2UgMjoKIAkJaWYgKG9wID09IE9QX0VRIHx8IG9wID09IE9QX05FKQogCQkJZm4gPSBm
aWx0ZXJfcHJlZF8xNjsKKyAgICAgICAgICAgICAgICBlbHNlIGlmIChvcCA9PSBPUF9ORV9QUkVW
KQorCQkJZm4gPSBmaWx0ZXJfbmVfcHJldl9wcmVkXzE2OyAgICAgICAgICAgICAgICAKIAkJZWxz
ZSBpZiAoZmllbGRfaXNfc2lnbmVkKQogCQkJZm4gPSBwcmVkX2Z1bmNzX3MxNltvcCAtIFBSRURf
RlVOQ19TVEFSVF07CiAJCWVsc2UKQEAgLTEwMjEsNiArMTA0OSw4IEBAIHN0YXRpYyBmaWx0ZXJf
cHJlZF9mbl90IHNlbGVjdF9jb21wYXJpc29uX2ZuKGVudW0gZmlsdGVyX29wX2lkcyBvcCwKIAlj
YXNlIDE6CiAJCWlmIChvcCA9PSBPUF9FUSB8fCBvcCA9PSBPUF9ORSkKIAkJCWZuID0gZmlsdGVy
X3ByZWRfODsKKyAgICAgICAgICAgICAgICBlbHNlIGlmIChvcCA9PSBPUF9ORV9QUkVWKQorCQkJ
Zm4gPSBmaWx0ZXJfbmVfcHJldl9wcmVkXzg7ICAgICAgICAgICAgICAgIAogCQllbHNlIGlmIChm
aWVsZF9pc19zaWduZWQpCiAJCQlmbiA9IHByZWRfZnVuY3Nfczhbb3AgLSBQUkVEX0ZVTkNfU1RB
UlRdOwogCQllbHNlCkBAIC0xMDg4LDcgKzExMTgsNyBAQCBzdGF0aWMgaW50IGluaXRfcHJlZChz
dHJ1Y3QgZmlsdGVyX3BhcnNlX3N0YXRlICpwcywKIAkJfQogCX0KIAotCWlmIChwcmVkLT5vcCA9
PSBPUF9ORSkKKwlpZiAocHJlZC0+b3AgPT0gT1BfTkUgfHwgcHJlZC0+b3AgPT0gT1BfTkVfUFJF
VikKIAkJcHJlZC0+bm90IF49IDE7CiAKIAlwcmVkLT5mbiA9IGZuOwpAQCAtMjE5Nyw3ICsyMjI3
LDcgQEAgc3RhdGljIGludCBmdHJhY2VfZnVuY3Rpb25fY2hlY2tfcHJlZChzdHJ1Y3QgZmlsdGVy
X3ByZWQgKnByZWQsIGludCBsZWFmKQogCQkgKiAgLSBvbmx5ICc9PScgYW5kICchPScgaXMgdXNl
ZAogCQkgKiAgLSB0aGUgJ2lwJyBmaWVsZCBpcyB1c2VkCiAJCSAqLwotCQlpZiAoKHByZWQtPm9w
ICE9IE9QX0VRKSAmJiAocHJlZC0+b3AgIT0gT1BfTkUpKQorCQlpZiAoKHByZWQtPm9wICE9IE9Q
X0VRKSAmJiAocHJlZC0+b3AgIT0gT1BfTkUpICYmIChwcmVkLT5vcCAhPSBPUF9ORV9QUkVWKSkK
IAkJCXJldHVybiAtRUlOVkFMOwogCiAJCWlmIChzdHJjbXAoZmllbGQtPm5hbWUsICJpcCIpKQo=
--94eb2c0956107622970564fcdfe7--
