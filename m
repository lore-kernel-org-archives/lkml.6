Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495PnVjk/Up1867yfrJpKnRLeF5ropwmHxJRgHOML4IQtVPPCd7bQecxgRrHgNH6s2FBib7
ARC-Seal: i=1; a=rsa-sha256; t=1523021156; cv=none;
        d=google.com; s=arc-20160816;
        b=RL8gjybbFBwO34qb/BB2gttDAxlFGWA/CSNwwdTieDRBG8SRNXhbUuwJkAVN2BlHa3
         GvNokiGWo1Te/SiTqevtwwoxznsSprescvukbMX5Y7TUGMF17BOJpyDuI16N5kbl3bv+
         z08sdFe8JrBdI5+Qh6WER44QFjQVnBCqGDTl4WBtDTXdwnzSpJZAnnzJ+bfh+wVOBS3K
         DVYulfkxH9UQepqRbSYV7tDRfMEsbAaDppnvwOa+ovk9NX0herVpHNNFojO/FTxV9aEQ
         u+FB3TBLPuSQ3gf0PY7JTCoF1XsKzAcn4tglHNoqEY6UXeWUURvzUUuV8IgxoOhoSlD+
         ohBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=C46oGZ/SIcve4CYD5Dcw7ON1AYaNRzF5TGgz7GokqLU=;
        b=G6nqhnxJekLC01bn7tjW7aen2WgX3AP632SiKyqlvte5kkhKp7qXLUL6Yn6yjE3Q7Q
         IznOHrOitD7T6QO8qXcqjZUseIWQwRWb2Quj06mMSZXAYF4zBgYoR4LARJE2uze0PqIm
         mVVBrRXtYOArS3+yrKRj3Zkg8/IE2K6wQ5S8J2g5yBRHCOMtsr3po5r1IcR27n8C88pj
         bRKpSOMs/R6xwDWC/9GcsBpYEFy24zB124SjOz8c+p6aDXfTtGwF/4aqTrvdnyV1evO0
         IUFbe+fkhAif4pAQhn0r49ukxYG1TWj5OxS8gEEc3eyLklon1krlDffVgkChppn46kWP
         Yi8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 28/93] netlink: avoid a double skb free in genlmsg_mcast()
Date: Fri,  6 Apr 2018 15:22:57 +0200
Message-Id: <20180406084226.185794931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003432445532624?=
X-GMAIL-MSGID: =?utf-8?q?1597003432445532624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>


[ Upstream commit 02a2385f37a7c6594c9d89b64c4a1451276f08eb ]

nlmsg_multicast() consumes always the skb, thus the original skb must be
freed only when this function is called with a clone.

Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/genetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1083,7 +1083,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
