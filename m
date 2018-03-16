Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtt/oL1ZtAa1mDbx8+7T6xTCHy3yKoAdQVtAj3cRmLgwmUZv7a8z2o2WOFQuWeSgjurM/mr
ARC-Seal: i=1; a=rsa-sha256; t=1521214095; cv=none;
        d=google.com; s=arc-20160816;
        b=TlFvUEferQX3KqVJWtz2hxONmNR2OzZgvtRcKNZYvY8RgzQ7MteFxKwFdviK64fdzw
         LGELQg0j40TIMsBEVSAFlUrfUEZPMKlCdmuLBUqGjIVwDthU1DAJJ2S8mm4a60F4YHF3
         /0tTciFOY/vESFTGwu+GIvU8P8nAu1SBrEjSprHEGRfHmGwD1bfA+xgwu5vOn1o9noZm
         aFFEVLErD77xEkwF7BGHdhqaoLv2sjFCiMBwo9Rs0k5fF/wgxgbem0aXBll8udjNtZFC
         6xQn0oBtvYww2O22TtLLckg7nTUoZSbOhrkoFpVIEMlIV8jDviTU61Q9qUZ9cTm//myX
         cgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L6UxLQ9nyPBpZNW6/+ZUeoDt9y/lfNoT0eoRotC9ruI=;
        b=adENegkZG/eTb3U2iqsy1QqkohtV6Bv3hQHu9kVPh/Ft4ib10jWHmzh0tsZZwvAgNy
         CIpinkrrzSJgHPNc4B1F+1s9bEu3aaS8anfEpDe3VL78tOjDU7IKAPAO05UWvi35m0V6
         Iy6zsRhuWciKax0ON8g5oJrHdGyqWAmasdrEdz5ZxybYVDWFXL/1SXpv4wXUNnqrshwB
         oKlplOlGpli8ipo6Kf/7U6Hl/GAFQndyepiVXQt8l9LA1ORNyYe0+W+nc5cYq+XtN6xL
         fx86cZnpxF3HkzV2izIlP0YDnpKFKkOrVhYWyU4vW0FM7xKNTky6Bz7ewA2qXDrypvyN
         ldog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 38/63] netfilter: ebtables: CONFIG_COMPAT: dont trust userland offsets
Date: Fri, 16 Mar 2018 16:23:10 +0100
Message-Id: <20180316152304.286711058@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108472340745037?=
X-GMAIL-MSGID: =?utf-8?q?1595108590872277624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2021,7 +2021,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2078,6 +2080,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
