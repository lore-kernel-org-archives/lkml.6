Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtYJUhnrPH+fgF668KIbH/kWD89D+hcgeLRRFoMisXQSMKs5eKBBZgNYKxtnLZj2pW4T1qO
ARC-Seal: i=1; a=rsa-sha256; t=1521483780; cv=none;
        d=google.com; s=arc-20160816;
        b=BH/qcNYBPjuQg7iJGxi8d8HTJKegkqf+TEE0R0KRv39oYicyZWFP+TOmFnSa6AtC/j
         ZsBalV4CVbS/OZq4JvtDLgdUwPKIjlT5vs9G1TKDUzb7hm7X7ncmAoSKBDBrtS3d2W47
         zA4IT0DfsVloiL0P0J/rM8h6e8haQiq6RYDCcCHx4HFs3hBgPbrTJQ7MskY0uO4bs7AD
         hv4NTkv6Rab/KMSRbzXSLJxdfattlNGRWoUh/5oLxFiVo2VbjghwXIscGKheZinP17qS
         y+3PMa+KdT2kwxbPHaLP3TcHONKNTTQ3d33ROjb1tG5D53Om6pdnaWVMhhaV0Ma4WESL
         bzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gL21BlfTNmFLf9NC9gTEMPuwukS0BnRx1L7KJn9XWbM=;
        b=RSF+gOgVkqHjz/FjkUT2yHfKHogo/J7seKhXro2afN4gWyAFMzrIQj0sm7UNWHYnvw
         JJyp3IUIcCQrlsCqBWf0NxrcSzxwU8dm+OYzOJj7mKJLXj/pNN8ftEXcAYs1PTpeK+fE
         YeoOIWe4Qfwp1bxP8QLbGcD4CO2FPgyR1Vg+LarAKZchZlToXDWpvmMjfbiR1W7f8B8T
         rZPYx6AGUQCrPp2NXLoBrnPP++4nE8P3KSQr07xTwiKuYh1bMJUj9sFdUqaLJ82Wc7IL
         IXHPFzHeIIBBYEe34nOpUFFeBPoIdelr9EN7SkJJ2Q02n4H1OGp+GopHpXEd9ECmGT2B
         YAzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuval Mintz <Yuval.Mintz@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 115/241] qed: Correct MSI-x for storage
Date: Mon, 19 Mar 2018 19:06:20 +0100
Message-Id: <20180319180755.968501050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391376451817393?=
X-GMAIL-MSGID: =?utf-8?q?1595391376451817393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>


[ Upstream commit 2f78227874754b1e10cd348fd6e7693b0dabb3f6 ]

When qedr is enabled, qed would try dividing the msi-x vectors between
L2 and RoCE, starting with L2 and providing it with sufficient vectors
for its queues.

Problem is qed would also do that for storage partitions, and as those
don't need queues it would lead qed to award those partitions with 0
msi-x vectors, causing them to believe theye're using INTa and
preventing them from operating.

Fixes: 51ff17251c9c ("qed: Add support for RoCE hw init")
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -711,7 +711,8 @@ static int qed_slowpath_setup_int(struct
 	cdev->int_params.fp_msix_cnt = cdev->int_params.out.num_vectors -
 				       cdev->num_hwfns;
 
-	if (!IS_ENABLED(CONFIG_QED_RDMA))
+	if (!IS_ENABLED(CONFIG_QED_RDMA) ||
+	    QED_LEADING_HWFN(cdev)->hw_info.personality != QED_PCI_ETH_ROCE)
 		return 0;
 
 	for_each_hwfn(cdev, i)
