Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvEyBN/xOxKuGiVEGuVQdJeghQ24sBnXZDlOqs4JzkJslJqjwytdhspwhYsIInilGPhT13C
ARC-Seal: i=1; a=rsa-sha256; t=1520451951; cv=none;
        d=google.com; s=arc-20160816;
        b=PW/5FXFJg6zwblb0RTpiwHcD3XGYGDWoftPqwDJJjmvYWBuWZm+8GSvbbmQ298em86
         LrOszbedV6BH4+iGHliIluZp9TMwqBs1swxE71bgHBUgXCdY4babIBby9NTFqwjEl/ed
         IO2+dVnpM6HvCjKC7xGMFdW3bL1Q1OByxgr+292ewtrekwCRXbbtbELopd8Yc06Jf8y5
         4BcQTrMenVNYs+jE7tKkYoRor1pvBLc7rpjgK5aamty1jRLtptoBlWNhzTbGl0pnfg16
         iyjrX/434O8mgT1SUpBMjMJ463KtEkSpzEcf4BUh8p+jH+QQxxaIfryqHpSfuTEQPMCA
         wejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cKlGJHY75vTyquG2u9MefodLJfcXT+1YsCVEM6gUeo0=;
        b=yVxIqGRPXbigzAVw6L3wR3eww/mgHqlbo+euZ0jY6peeKOUlgjpOZkUkYnQ4NSjgoY
         CmM+R2RhuDogG4TkO4k7P2LTs17h+4qktI6NUCR7cM4K2wMwN1lTsRtU+ihy4OttTxVG
         RZMoFxvjXYlurwskAjpak0mvByJzfE0J/+qapkd0FNcbfioE9ERXtrmeqR+ZdnVhD925
         Msc632tutzlkQBnRgKxGwXFSrwmmSRV0IH4El9CV7Ds0dT01aBo+B+ptn8FTN4dgm1Ww
         S5sgHCDS8LyDn+PR8CzlD58H5hgBgOi3eKIuF9i93dk7Na+tXEEjXKLLMvE623pawGgg
         GgSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Kapl <code@rkapl.cz>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 043/110] net: sched: report if filter is too large to dump
Date: Wed,  7 Mar 2018 11:38:26 -0800
Message-Id: <20180307191045.241327158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309134390300102?=
X-GMAIL-MSGID: =?utf-8?q?1594309426041058096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <code@rkapl.cz>


[ Upstream commit 5ae437ad5a2ed573b1ebb04e0afa70b8869f88dd ]

So far, if the filter was too large to fit in the allocated skb, the
kernel did not return any error and stopped dumping. Modify the dumper
so that it returns -EMSGSIZE when a filter fails to dump and it is the
first filter in the skb. If we are not first, we will get a next chance
with more room.

I understand this is pretty near to being an API change, but the
original design (silent truncation) can be considered a bug.

Note: The error case can happen pretty easily if you create a filter
with 32 actions and have 4kb pages. Also recent versions of iproute try
to be clever with their buffer allocation size, which in turn leads to

Signed-off-by: Roman Kapl <code@rkapl.cz>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -871,13 +871,18 @@ static int tc_dump_tfilter(struct sk_buf
 		if (tca[TCA_CHAIN] &&
 		    nla_get_u32(tca[TCA_CHAIN]) != chain->index)
 			continue;
-		if (!tcf_chain_dump(chain, skb, cb, index_start, &index))
+		if (!tcf_chain_dump(chain, skb, cb, index_start, &index)) {
+			err = -EMSGSIZE;
 			break;
+		}
 	}
 
 	cb->args[0] = index;
 
 out:
+	/* If we did no progress, the error (EMSGSIZE) is real */
+	if (skb->len == 0 && err)
+		return err;
 	return skb->len;
 }
 
