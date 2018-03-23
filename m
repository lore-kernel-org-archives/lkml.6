Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJNqCckERox79ZuKlZqfVRoL8P8BBp6pVdVssG4H1gYU0ZGaJ9JaoXk/P4IKyMa3nvaUMD
ARC-Seal: i=1; a=rsa-sha256; t=1521800112; cv=none;
        d=google.com; s=arc-20160816;
        b=Me/fcFXW3HeJvEM5t7UfwPgIe8mPA6irinLCU52oUKrPjvt1yg1TTNcvZkweoHGnSg
         VJKeOlYXsFmbYcLu/rUSGGd80bRaVY0jX4YWwyTmALtHjtfGxDDO3ySV7gEeKpnetdvH
         YGVr5mVuakB6nqvfZw5BWp0m03n/OAtC92Yx2yeKsRsnQszE3Xmp9rWGRkX//N8yc076
         KT1RagP5znRpV4CiMXTj1GV3idq3d8bzeuYsyRX1YxPQ8humadPmUQcRX2QqwyyM+niE
         wZcRELLl0waeuo1llKRG5LIgiayA2PmVWT6drYd+UP/u15qYsvZ6vXKZ88jMpAz+3ccr
         V6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EnoQP+ni2v24iiECeokEjwHfYEvWQtLHyYeVtXPBAb4=;
        b=YkypetYPysAmvuGgexXs06vLucTfodHBy60onaCAvWguDBhSRkLvv9/pVAB+lr14Lk
         RiK8H+Z3i62O4JsZgiDOEdRu5NznGNuOlFy/TF04xoN36mbCxoPHRWOQt4m8hUReqiIx
         5dFyGxUo+d4QXQULn8ESgRXWz9ZO+Rjn6UlwuQh6rmvqrHm68+v487CVraaLMYUykPzS
         9Ol5APl1X6+D/ANi7KzsehbDPXsO3ZKzu0SEG6HRLQWJaYDAjutgahSCJMS40n+sYu6j
         cVJQx5ZQOatLfs9AEuCM2GOWeQ2ECDEzF/TXSqBQ7M2mJ6ZXpR67IrEajeIw0/DWfy4b
         9NlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gao Feng <fgao@ikuai8.com>,
	Liping Zhang <zlpnobody@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 38/97] netfilter: xt_CT: fix refcnt leak on error path
Date: Fri, 23 Mar 2018 10:54:25 +0100
Message-Id: <20180323094159.781131756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722577355662654?=
X-GMAIL-MSGID: =?utf-8?q?1595723074905030099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <fgao@ikuai8.com>


[ Upstream commit 470acf55a021713869b9bcc967268ac90c8a0fac ]

There are two cases which causes refcnt leak.

1. When nf_ct_timeout_ext_add failed in xt_ct_set_timeout, it should
free the timeout refcnt.
Now goto the err_put_timeout error handler instead of going ahead.

2. When the time policy is not found, we should call module_put.
Otherwise, the related cthelper module cannot be removed anymore.
It is easy to reproduce by typing the following command:
  # iptables -t raw -A OUTPUT -p tcp -j CT --helper ftp --timeout xxx

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_CT.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -168,8 +168,10 @@ xt_ct_set_timeout(struct nf_conn *ct, co
 		goto err_put_timeout;
 	}
 	timeout_ext = nf_ct_timeout_ext_add(ct, timeout, GFP_ATOMIC);
-	if (timeout_ext == NULL)
+	if (!timeout_ext) {
 		ret = -ENOMEM;
+		goto err_put_timeout;
+	}
 
 	rcu_read_unlock();
 	return ret;
@@ -201,6 +203,7 @@ static int xt_ct_tg_check(const struct x
 			  struct xt_ct_target_info_v1 *info)
 {
 	struct nf_conntrack_zone zone;
+	struct nf_conn_help *help;
 	struct nf_conn *ct;
 	int ret = -EOPNOTSUPP;
 
@@ -249,7 +252,7 @@ static int xt_ct_tg_check(const struct x
 	if (info->timeout[0]) {
 		ret = xt_ct_set_timeout(ct, par, info->timeout);
 		if (ret < 0)
-			goto err3;
+			goto err4;
 	}
 	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
 	nf_conntrack_get(&ct->ct_general);
@@ -257,6 +260,10 @@ out:
 	info->ct = ct;
 	return 0;
 
+err4:
+	help = nfct_help(ct);
+	if (help)
+		module_put(help->helper->me);
 err3:
 	nf_ct_tmpl_free(ct);
 err2:
