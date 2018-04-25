Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Y3zCVqulPPGvCF7iQ+J2UA7DPsXlmbB/5/e2aOCdMraBIzTSd4qYZzNJwNcA16PtzxUch
ARC-Seal: i=1; a=rsa-sha256; t=1524652703; cv=none;
        d=google.com; s=arc-20160816;
        b=NU2i4pFzp0RNvSi4Bvirx6YlFBYk1jMIMGDCTBFdUO0bItDdd3CT1WOhubnNauJpel
         6G7qgwLkuBxQMXC1RVekgqgFrlSbgNwqhSnvdCxmb2vWOuZQceBs7q/WSUSwu0ReYhbl
         sxe0KEylM+HpK4rIU7Y/xdygdqCpfRgIRVI4FE/rEhTh0/l1HCSWM4OvdwoamvEIzLnN
         1ONbwzfOWEUxh0qfpwiHKaX9q7coY/XKW3ltjXI8rWcKjfMpKBZYIMPvjMtB+ML5c27f
         O4q1u0PFlQfU1TaD9LgZ+QbtwbZyi7qtu9loCtsX7CJoMjHv/lto/YHPDQ6DQog6hEKu
         sSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MEFHhIsURMYD3dN3QyShixJQC0fc265c4Dq/IYAl3lw=;
        b=b+87bi7P7n0yKn0TCoGOwbbSJmSk8MZvdqswAODjyv7A5A7+htTSISLlOuYI35VX/k
         R5oHe17NhWaVC4GBGzAZF0uvLdmPCVPgyxCbr32bbREw8TdaNmkhR/sj2TaAePALcJUB
         0GvdiuSTof21CDDR54OAkmS/E8Bc0QE+29tiZVab0e4p7cO4zhnUpP1aY/S0mY47slRp
         9xRyDkbLL9BN8X4/P3kqYzuMiiR4U0mZ6VNB3bCOjNnh9Eg6GG6F1Po+rl7R4crwz0PS
         ovtcDn1TFcBQsX6TTxNogfTGQ4cfl/ISA3iYS7zXOSqPpmKUVI452OQujII0WCChG0vt
         Etdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 039/183] tools lib traceevent: Simplify pointer print logic and fix %pF
Date: Wed, 25 Apr 2018 12:34:19 +0200
Message-Id: <20180425103244.147200447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714233761517284?=
X-GMAIL-MSGID: =?utf-8?q?1598714233761517284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>


[ Upstream commit 38d70b7ca1769f26c0b79f3c08ff2cc949712b59 ]

When processing %pX in pretty_print(), simplify the logic slightly by
incrementing the ptr to the format string if isalnum(ptr[1]) is true.
This follows the logic a bit more closely to what is in the kernel.

Also, this fixes a small bug where %pF was not giving the offset of the
function.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.260262257@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/traceevent/event-parse.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4949,21 +4949,22 @@ static void pretty_print(struct trace_se
 				else
 					ls = 2;
 
-				if (*(ptr+1) == 'F' || *(ptr+1) == 'f' ||
-				    *(ptr+1) == 'S' || *(ptr+1) == 's') {
+				if (isalnum(ptr[1]))
 					ptr++;
+
+				if (*ptr == 'F' || *ptr == 'f' ||
+				    *ptr == 'S' || *ptr == 's') {
 					show_func = *ptr;
-				} else if (*(ptr+1) == 'M' || *(ptr+1) == 'm') {
-					print_mac_arg(s, *(ptr+1), data, size, event, arg);
-					ptr++;
+				} else if (*ptr == 'M' || *ptr == 'm') {
+					print_mac_arg(s, *ptr, data, size, event, arg);
 					arg = arg->next;
 					break;
-				} else if (*(ptr+1) == 'I' || *(ptr+1) == 'i') {
+				} else if (*ptr == 'I' || *ptr == 'i') {
 					int n;
 
-					n = print_ip_arg(s, ptr+1, data, size, event, arg);
+					n = print_ip_arg(s, ptr, data, size, event, arg);
 					if (n > 0) {
-						ptr += n;
+						ptr += n - 1;
 						arg = arg->next;
 						break;
 					}
