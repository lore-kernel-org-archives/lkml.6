Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+G+laGTJvUffakB/N46LXdEZd3QF+gyMQUhCR0nk01OwOL7/B7VbR7JaYv7imE0XBiKBQt
ARC-Seal: i=1; a=rsa-sha256; t=1523021409; cv=none;
        d=google.com; s=arc-20160816;
        b=aplRa7Zd1fxTE3sOpxQm0uRC0i74FamB7zz7hwv5vElNtcC0dEkDy7DuE1+6cs3V/V
         nnCbFzyCwdCVs7sDnFRAh5MditaKOLI4f6KARhbgIQ1hBdr5RJGFC2RKwhVSIfe9vhT+
         ISnxhKVGHbM2dZIdbOWNuagl3GAFeytXvtEyrBAFN/kBnLzJsFhy7Gr4Q4F+FKofjhYe
         llMsI9Rb67MJfxN4aqzTW7zFLfEu3kXQUOdbas0Cem85rIEolPS0gpsajkFX9q8QTvGC
         3mDwG8L6N+cHT7fytPzixcNr3NWBpCeWsxBxgfVGVfcO2I117zA81tyntNdXn0yQX2r3
         5QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ulbXOhbXuv9TwjqQfCIjwEML99gQEvGJFo0/Ni45Axc=;
        b=HGaiExrHy7rnKdxvWCCfV7v5ozYuf4n0KoJXnVmTotFUJFao80c10+I4lHhtQFROqd
         zpqoCcksKocxLQYeTTPi41iTckKQjgm2kWWGPCbQfk5M9hzk6j6ry+srOVh3Q9z0mik8
         6AX1sKPSZGXl4+7NjsFbHbm+amMg3VyGouH7pAcypQdejZYmky0MiAHC1ZZhn4FIVuta
         /hWBxT+wyub1Iae4KD64iXSCzSsFvdyW+PzViLYaPNWRBztdirhoI1z6ENLo0YEoe8dA
         tfbzC9m+UHP0sp2jX579I+Gd7axqMKY1MEUw9GjE/lBsm9LBYkm1iR8TaSGHZs4ksJjz
         oVmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 26/72] netfilter: ctnetlink: Make some parameters integer to avoid enum mismatch
Date: Fri,  6 Apr 2018 15:23:27 +0200
Message-Id: <20180406084307.355747747@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003697537524572?=
X-GMAIL-MSGID: =?utf-8?q?1597003697537524572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit a2b7cbdd2559aff06cebc28a7150f81c307a90d3 upstream.

Not all parameters passed to ctnetlink_parse_tuple() and
ctnetlink_exp_dump_tuple() match the enum type in the signatures of these
functions. Since this is intended change the argument type of to be an
unsigned integer value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[natechancellor: ctnetlink_exp_dump_tuple is still inline]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_netlink.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -999,9 +999,8 @@ static const struct nla_policy tuple_nla
 
 static int
 ctnetlink_parse_tuple(const struct nlattr * const cda[],
-		      struct nf_conntrack_tuple *tuple,
-		      enum ctattr_type type, u_int8_t l3num,
-		      struct nf_conntrack_zone *zone)
+		      struct nf_conntrack_tuple *tuple, u32 type,
+		      u_int8_t l3num, struct nf_conntrack_zone *zone)
 {
 	struct nlattr *tb[CTA_TUPLE_MAX+1];
 	int err;
@@ -2416,7 +2415,7 @@ static struct nfnl_ct_hook ctnetlink_glu
 static inline int
 ctnetlink_exp_dump_tuple(struct sk_buff *skb,
 			 const struct nf_conntrack_tuple *tuple,
-			 enum ctattr_expect type)
+			 u32 type)
 {
 	struct nlattr *nest_parms;
 
