Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDSCr4Met5F+cQbQQjJF6d13c78puK1bkEfELpqm8LPcgVm/OnB882Ucnei1IMmi9zvOah
ARC-Seal: i=1; a=rsa-sha256; t=1527155994; cv=none;
        d=google.com; s=arc-20160816;
        b=QlS0GDL9szE1YjU1phFmzKM0FlwK9BHdhjJljdxmhwh8W2Zm2W/DNJxRG84ALhuBld
         T9WCZmGQx9YLgKHVfj1nJcKWXHbiZ7emmVPY5Mfe5Q7oCnVVBYamvoDYiZYVx2QoaU4N
         LiTg+zrKl6kqfqCZtC8iwjigMV7J+lnpbReLDkzBgTvHtmOp6EtHgVX4puWeTcy8Dc8H
         8XspJBxclg62q5MYk+ECbq6gT0mWJmqZexlP2eCeXCt/ilN2yXsfLeB/NKs4hNC2JG0t
         Uv4fqKJ3CC0WUrNwBd2SsI8B570xJ75YcJkE1iYKvjhhqEqYqhfx9cTICACDtz4MY/GI
         wIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lhQ8jgc+euppsguZrHSL69IdoT4Q4Wow0mPoNfHwNzs=;
        b=iaHFEbfqB9ERDB0fLWW8T1l9KLWnh2bdaurVKB+W5T4111QM/VZ6ZJHWv+SUrUdCFE
         yosvMDXgOfc0LHEN2/DcHho7PGrfRcXCx2hqr5ExE+bxO2G9UzJyL4tI41ppe9nrsYj6
         MkmXme3xhbNGzEMrGQhiHHXAYL+koemOgASebrJHh+UOPSRT/qA5eXcynyLud9jw/BLi
         kwZTtWJs6ijcJ9bPxuZPREdZFXhZS6lwb8uFip8EgNn6zzod0w/x0t39MDAoHVJ7w1e/
         ZqfOIDGiwYVrcTiYSWlsuXVptj+Huse4DMOaiUbnqNyjW3mluDtLkzPYCJt47Zzjqjlg
         O9kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HM2ZIQMO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HM2ZIQMO;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 006/161] net/smc: check for missing nlattrs in SMC_PNETID messages
Date: Thu, 24 May 2018 11:37:11 +0200
Message-Id: <20180524093019.138994906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338666913354949?=
X-GMAIL-MSGID: =?utf-8?q?1601339123225883807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit d49baa7e12ee70c0a7b821d088a770c94c02e494 ]

It's possible to crash the kernel in several different ways by sending
messages to the SMC_PNETID generic netlink family that are missing the
expected attributes:

- Missing SMC_PNETID_NAME => null pointer dereference when comparing
  names.
- Missing SMC_PNETID_ETHNAME => null pointer dereference accessing
  smc_pnetentry::ndev.
- Missing SMC_PNETID_IBNAME => null pointer dereference accessing
  smc_pnetentry::smcibdev.
- Missing SMC_PNETID_IBPORT => out of bounds array access to
  smc_ib_device::pattr[-1].

Fix it by validating that all expected attributes are present and that
SMC_PNETID_IBPORT is nonzero.

Reported-by: syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com
Fixes: 6812baabf24d ("smc: establish pnet table management")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_pnet.c |   71 +++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -245,40 +245,45 @@ out:
 static int smc_pnet_fill_entry(struct net *net, struct smc_pnetentry *pnetelem,
 			       struct nlattr *tb[])
 {
-	char *string, *ibname = NULL;
-	int rc = 0;
+	char *string, *ibname;
+	int rc;
 
 	memset(pnetelem, 0, sizeof(*pnetelem));
 	INIT_LIST_HEAD(&pnetelem->list);
-	if (tb[SMC_PNETID_NAME]) {
-		string = (char *)nla_data(tb[SMC_PNETID_NAME]);
-		if (!smc_pnetid_valid(string, pnetelem->pnet_name)) {
-			rc = -EINVAL;
-			goto error;
-		}
-	}
-	if (tb[SMC_PNETID_ETHNAME]) {
-		string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
-		pnetelem->ndev = dev_get_by_name(net, string);
-		if (!pnetelem->ndev)
-			return -ENOENT;
-	}
-	if (tb[SMC_PNETID_IBNAME]) {
-		ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
-		ibname = strim(ibname);
-		pnetelem->smcibdev = smc_pnet_find_ib(ibname);
-		if (!pnetelem->smcibdev) {
-			rc = -ENOENT;
-			goto error;
-		}
-	}
-	if (tb[SMC_PNETID_IBPORT]) {
-		pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
-		if (pnetelem->ib_port > SMC_MAX_PORTS) {
-			rc = -EINVAL;
-			goto error;
-		}
-	}
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_NAME])
+		goto error;
+	string = (char *)nla_data(tb[SMC_PNETID_NAME]);
+	if (!smc_pnetid_valid(string, pnetelem->pnet_name))
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_ETHNAME])
+		goto error;
+	rc = -ENOENT;
+	string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
+	pnetelem->ndev = dev_get_by_name(net, string);
+	if (!pnetelem->ndev)
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_IBNAME])
+		goto error;
+	rc = -ENOENT;
+	ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
+	ibname = strim(ibname);
+	pnetelem->smcibdev = smc_pnet_find_ib(ibname);
+	if (!pnetelem->smcibdev)
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_IBPORT])
+		goto error;
+	pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
+	if (pnetelem->ib_port < 1 || pnetelem->ib_port > SMC_MAX_PORTS)
+		goto error;
+
 	return 0;
 
 error:
@@ -307,6 +312,8 @@ static int smc_pnet_get(struct sk_buff *
 	void *hdr;
 	int rc;
 
+	if (!info->attrs[SMC_PNETID_NAME])
+		return -EINVAL;
 	pnetelem = smc_pnet_find_pnetid(
 				(char *)nla_data(info->attrs[SMC_PNETID_NAME]));
 	if (!pnetelem)
@@ -359,6 +366,8 @@ static int smc_pnet_add(struct sk_buff *
 
 static int smc_pnet_del(struct sk_buff *skb, struct genl_info *info)
 {
+	if (!info->attrs[SMC_PNETID_NAME])
+		return -EINVAL;
 	return smc_pnet_remove_by_pnetid(
 				(char *)nla_data(info->attrs[SMC_PNETID_NAME]));
 }
