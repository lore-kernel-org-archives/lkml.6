Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBziQGRU1wXrGmyXgheZsqsNbqp5pT+PmqmyN1eE7D0eZP9ydoqdxoR37pdxwur+zpPAcd
ARC-Seal: i=1; a=rsa-sha256; t=1521483247; cv=none;
        d=google.com; s=arc-20160816;
        b=KVgT2PjSN2o6JxVqea3Qoho13rGIDS/16OqGCnPMsnpDGVszekNjUr435yDIz+sDU/
         egTt9JaWSHPina1KCl2sleFdS4w1vgKRA79xSxdaeUs8ibH1pdDNk3JE1D2fxBk5p9FU
         Bqq5wMu9FJ34nVjqfdF5zHFQlRIvF3Hll9g8whHDFVJu1KydbYqj//bKojz7Bq2XGeB0
         rGihikW5bFo+hirS/N/cw77MPOE4QMvCJKXw7sCUkl2TFM5gE/1458APMR8Rd6zSbTFw
         w6jmg4ohrWpDGpu8mOmjozmA1+hgea3x7Q2D9wu87DoiucRm9AkTgme9WPsA/VURcbTV
         gm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vpG+YeKEEFQPGiUekxBLNiAlTdMF9+7IGvsO+FYBAKE=;
        b=zMl9+50dWQA1f++Y3kjKAbccjSC/o5fwwovSUyLBPE6hNuJnj8/72iaD2qm6oR9iHc
         V+oQVlz/w1j8DFspw1GprkL6Tc9fDtJXursX8dp+AIY7JTDjdVc1rAkIb02JF15P1Pwz
         NYGsjNA+EHm6RirO4bIP/9C97BeJsKdVT8rkd7imjwII2CmkbI4dsxPS3Kn/uF6Ua26o
         O6N82lPNSxelxjjml80hrFdz6df/i3ptlwcuygPcN5w0VNkg/LFw8tgBQwKPEfd+vIay
         sWXO3IVc2pwFSWMyv0pCs+t7yB5Ni/dEScRbaZGZGSiNIahdZJMzRMnltEztUEEwjo2n
         jXew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Phil Turnbull <phil.turnbull@oracle.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 054/134] fm10k: correctly check if interface is removed
Date: Mon, 19 Mar 2018 19:05:37 +0100
Message-Id: <20180319171857.167281647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390554893917373?=
X-GMAIL-MSGID: =?utf-8?q?1595390817800036820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Turnbull <phil.turnbull@oracle.com>


[ Upstream commit 540fca35e38d15777b310f450f63f056e63039f5 ]

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -983,7 +983,7 @@ static void fm10k_self_test(struct net_d
 
 	memset(data, 0, sizeof(*data) * FM10K_TEST_LEN);
 
-	if (FM10K_REMOVED(hw)) {
+	if (FM10K_REMOVED(hw->hw_addr)) {
 		netif_err(interface, drv, dev,
 			  "Interface removed - test blocked\n");
 		eth_test->flags |= ETH_TEST_FL_FAILED;
