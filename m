Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpPRthZ88HBhxmEOZq+BeJf8G071zP3iytvT3pgr+HxULsAjLpWIO2dmPVM8OnBcCUnV4NR
ARC-Seal: i=1; a=rsa-sha256; t=1524838286; cv=none;
        d=google.com; s=arc-20160816;
        b=Lubz5X2MwPOit7++sjA9g6VqLIkZaxZjZzgRmtae33VUvyMICKfK0rjqRkYpQAv4xQ
         SeLx8nLIK0/tIgekS71VA5g09iof+Ny5B2Bh8CLSd/Z84+fZHwCnRrcHhhhm5Agw1t4S
         yEWXTEtPkxvqcVUSPMWQ1ZwG9t3VuKBE0YTmqKZe0EnOx1klos2LG5pRLbvMO/6xYpRD
         fzKvOBMD6bDwPZfcAZ4+fN2PgKCDcHANhwi/y1BmMVh/cWU4uCbVk1rbRXJJCA8QL/f/
         h+hLMpee4yj2FgTAfvF+G7muVdH7b7KyRSNEspaIiIZvju+57xaQCqjltXOWO9LfrwRx
         IR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=vlXjXpJeFcwXW/1XAb5r2ougMe60e7YsfqsyVNhJ94s=;
        b=w4a+sUWwYcVHuRmk5BvVs8nXjBi75xHfG6WLWoMI+PY1f2942jqlPtjmRuyNSXM0Wo
         G4GpNRkTNPwy5PfHBZgycss/xA1kU3LE0HOmPWhpgRN0aW1onypSrV9b5OcQNRE8p1K2
         j0IbngKElVc60u5t5CjZFmuhxKFn7Iw1gOE1KxG9Nzl8oL5dPZHxrWZmVgnBZTWSlMUG
         auq7cfDAXEVn0KBs28fFVuotZ47QpKS8kpn1L0nwk98+8uw6iYPb3GwmWqkxjpXgE5U5
         XNQ6B0eFOx8vs23CjTNuYx+BhRA4nom+cDsOG8P7DhqZ+n0jyU3MDR5bTzIjkHZ8oAHE
         mtRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CC321892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 49/81] s390/qeth: handle failure on workqueue creation
Date: Fri, 27 Apr 2018 15:58:51 +0200
Message-Id: <20180427135746.006010437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908831825863828?=
X-GMAIL-MSGID: =?utf-8?q?1598908831825863828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>


[ Upstream commit a936b1ef37ce1e996533878f4b23944f9444dcdf ]

Creating the global workqueue during driver init may fail, deal with it.
Also, destroy the created workqueue on any subsequent error.

Fixes: 0f54761d167f ("qeth: Support VEPA mode")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6544,10 +6544,14 @@ static int __init qeth_core_init(void)
 	mutex_init(&qeth_mod_mutex);
 
 	qeth_wq = create_singlethread_workqueue("qeth_wq");
+	if (!qeth_wq) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
 
 	rc = qeth_register_dbf_views();
 	if (rc)
-		goto out_err;
+		goto dbf_err;
 	qeth_core_root_dev = root_device_register("qeth");
 	rc = PTR_ERR_OR_ZERO(qeth_core_root_dev);
 	if (rc)
@@ -6584,6 +6588,8 @@ slab_err:
 	root_device_unregister(qeth_core_root_dev);
 register_err:
 	qeth_unregister_dbf_views();
+dbf_err:
+	destroy_workqueue(qeth_wq);
 out_err:
 	pr_err("Initializing the qeth device driver failed\n");
 	return rc;
