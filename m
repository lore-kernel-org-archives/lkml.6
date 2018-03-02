Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtgyw1nFJnmsy+lM/mkA2glplUskvRpWFn1bi9DFmBLf5z3scUpLxv/KtHDaMEUd14rdvGG
ARC-Seal: i=1; a=rsa-sha256; t=1519981280; cv=none;
        d=google.com; s=arc-20160816;
        b=Qh8MtgXcJ1eE7hJgnX1AuB/LM7bMRusoC9+YHnfb0f1Ms+I6+JZBDu/HsQXkMe0whX
         hQl1LVCrgI4cqkQhJsgNe4HK6ryoY12PQHO9V0DOtlaa1AidC4zl4Bo20kHmcpLBKxRm
         YXtMRdw08tffSN7MTRpT0jKMMv3Uy+gOoJNz93uCQaN2ahW+E8/JFYZO1NuwePxfdljc
         lu4SewSHO9HKvFb10sUYSQZP7R3Io42OOknshgqRZw97HXue16wTT3lhnOEuE2XAB06m
         cjdGAC6O4f+jVg9Uqx1mNANzbWjcu1n/Gpc7hbMCBHsPssbhHKJ1udFQtfvJsgvrrmdw
         S7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DH6zXOWumibU4slls4PS41IxqAHJGjmmN+ueGCUd0p8=;
        b=Kg+aQrnvhbb/fZ/J4NJuyaCvMoRgsw/52iiISZnUG89h3NFmzie/JNz6crw3omT9HB
         9U5Pe7p1/Sy0QIBOwpcTG8fMHYVpPp5wvEt3RnETge3IwOXkQm+HZ7zoEAaSaG6PJwCH
         cQey3oN2TuPApJUUM3enDMTBJDk9X7wwq26cWiFgLq2uSSjKyDY1Tbkzkq7ezAwRzbBj
         sbNkADTRc/UhDM2rsvTtC571wMcwj3gYAyORrbH5uhvt/t/FMC+1cUqHdOeBLKfffww2
         4BABjMws5rCI2aQWK/96uRS+wwPmMs16clNfTC5M40LrZZeGX7mlqJfYqkyph+qyw2lS
         33GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li Shuang <shuali@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 045/115] netfilter: uapi: correct UNTRACKED conntrack state bit number
Date: Fri,  2 Mar 2018 09:50:48 +0100
Message-Id: <20180302084505.703190662@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815891383698453?=
X-GMAIL-MSGID: =?utf-8?q?1593815891383698453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>


[ Upstream commit 4c82fd0abb87e20d0d68ef5237e74732352806c8 ]

nft_ct exposes this bit to userspace.  This used to be

  #define NF_CT_STATE_UNTRACKED_BIT              (1 << (IP_CT_NUMBER + 1))
  (IP_CT_NUMBER is 5, so this was 0x40)

.. but this got changed to 8 (0x100) when the untracked object got removed.
Replace this with a literal 6 to prevent further incompatible changes
in case IP_CT_NUMBER ever increases.

Fixes: cc41c84b7e7f2 ("netfilter: kill the fake untracked conntrack objects")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/netfilter/nf_conntrack_common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/netfilter/nf_conntrack_common.h
+++ b/include/uapi/linux/netfilter/nf_conntrack_common.h
@@ -36,7 +36,7 @@ enum ip_conntrack_info {
 
 #define NF_CT_STATE_INVALID_BIT			(1 << 0)
 #define NF_CT_STATE_BIT(ctinfo)			(1 << ((ctinfo) % IP_CT_IS_REPLY + 1))
-#define NF_CT_STATE_UNTRACKED_BIT		(1 << (IP_CT_UNTRACKED + 1))
+#define NF_CT_STATE_UNTRACKED_BIT		(1 << 6)
 
 /* Bitset representing status of connection. */
 enum ip_conntrack_status {
