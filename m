Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoo4B7drroQ8Lemgyc4tt4xsjjjcfroDHEVvYqglInvZEV5geKS8tLDunJBEFQjOlAsGbCy
ARC-Seal: i=1; a=rsa-sha256; t=1524838237; cv=none;
        d=google.com; s=arc-20160816;
        b=F5Jjlz80AmcuFo/VVtpisEC0wI4D5MqoXIg25FL5u7d6uARbBQf4v/IgqvgTaOj2oM
         EMqBJDSHXQxz0bLkcd9fYyzpb53kq4yiAULWXYnFsoZxYZZ22gyCQ6a6hOVb69TqXamo
         UeRICk+ZtrOo4Tkow9jsFLdz3NF360MOsKl1eo4nj+gO6EsKSXmcadQ7O5XisMdTdDGB
         T+XUHs+COWJMAE6agc4V5rWKBa0nqJ2FobhoJra2KrMwu6qsVnVsqd5M8BQDNDLPdJpp
         uoudvjhcUCk4BamVTKt8Xjr5Mf57NafjF3Gk0y4mx1iO0j6BgNkKT/c0vda3tTfEyxXQ
         1exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=hH7ltUf7O6Pjbr6WGs57EVOS26VbW9YXO6ZWe0rEE2I=;
        b=nnIOIMFVrq8d0G5GAYJPbYFwKE76C+F8aUwnd8DcMISlXR4mtVFRGnEeLGqUYH5khM
         SRYyl2PLFC9OHHEOTQYxZeiogvDBBPKaROgF9RoocaS/tp6135Q7vMRo1ID0LpXjlj05
         cC/5qLyVyYbvd41Gh0pLemhGoMpCuTtSKraMgetqnX1cW4Bb/KYoiHqr1XYNg1/r5xFY
         8VbQL1dF5iErek5AgC+Ndr2N88fdH4yfV9Al33Bv6UAXwxrD1BkVBGWSm1OUxXGpbjwT
         rxp5uBB4jbORkA1d1dA9qTccbbvbj1Eo+eehWaBM3b5zdZJhGJ7mW5FOWteLWqdBGbpe
         v3eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B185521895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Pawe=C5=82=20Jab=C5=82o=C5=84ski?= <pawel.jablonski@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH 4.16 03/81] i40e: Fix attach VF to VM issue
Date: Fri, 27 Apr 2018 15:58:05 +0200
Message-Id: <20180427135743.481209175@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908551731107352?=
X-GMAIL-MSGID: =?utf-8?q?1598908779466929099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paweł Jabłoński <pawel.jablonski@intel.com>

commit 028daf80117376b22909becd9720daaefdfceff4 upstream.

Fix for "Resource temporarily unavailable" problem when virsh is
trying to attach a device to VM. When the VF driver is loaded on
host and virsh is trying to attach it to the VM and set a MAC
address, it ends with a race condition between i40e_reset_vf and
i40e_ndo_set_vf_mac functions. The bug is fixed by adding polling
in i40e_ndo_set_vf_mac function For when the VF is in Reset mode.

Signed-off-by: Paweł Jabłoński <pawel.jablonski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2889,6 +2889,7 @@ int i40e_ndo_set_vf_mac(struct net_devic
 	int ret = 0;
 	struct hlist_node *h;
 	int bkt;
+	u8 i;
 
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
@@ -2900,6 +2901,16 @@ int i40e_ndo_set_vf_mac(struct net_devic
 
 	vf = &(pf->vf[vf_id]);
 	vsi = pf->vsi[vf->lan_vsi_idx];
+
+	/* When the VF is resetting wait until it is done.
+	 * It can take up to 200 milliseconds,
+	 * but wait for up to 300 milliseconds to be safe.
+	 */
+	for (i = 0; i < 15; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+			break;
+		msleep(20);
+	}
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
 		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
 			vf_id);
