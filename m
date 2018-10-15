Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEFFC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339A220881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="l6qnlBR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339A220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:53:21 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40644 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbeJOTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:53:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FC0aXS031935;
        Mon, 15 Oct 2018 05:05:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=MWIm0010gvby7LqUJyfpJhanwbN7EJ/IVWXKT6C/3a4=;
 b=l6qnlBR37+zPbgGZo+pLKc6DyYtRcX/bJGrnD3jyfiflMgBvmz45Vtvrnw1yn1uMUvRi
 kKroCag91SIVrISTgCk78LCyVZ1vUG95HPjiZCB0E3AA1Cg236CeBXJmVpdnGUSC62PE
 +NGOa8iQcIF0J87g/BslsrjU2fWHwGH519MRuujVRIRnMyWjJaScxqs/55I6uPFEItFR
 6fq3AnadwlZ34GbcOC9NrNjAOKUndzn0sWQkRa4Jg0E+92pCpWs9RWSKBwW0hzTJGBOV
 KWSBhmHS7B/SSsCYnbfMv81GTocYWbcOuV+4YNv+8l3U1NSAHFaNqXDh563rO1mlCAAN pQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2n3g7jnwrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 05:05:21 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 15 Oct
 2018 05:05:19 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 15 Oct
 2018 15:05:16 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 15 Oct 2018 05:05:16 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 047CC3F703F;
        Mon, 15 Oct 2018 05:05:11 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <corbet@lwn.net>,
        <joro@8bytes.org>, <robh+dt@kernel.org>,
        <gregory.clement@bootlin.com>, <mark.rutland@arm.com>,
        <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <nadavh@marvell.com>,
        <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 0/4] Add system mmu support for Armada-806
Date:   Mon, 15 Oct 2018 15:00:42 +0300
Message-ID: <1539604846-21151-1-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

This series add support for IOMMU for AP806, including workaround
for accessing ARM SMMU 64bit registers.
AP-806 can't access SMMU registers with 64bit width, this patches split
the readq/writeq for 32bit access, due to erratanum #582743.

Hanna Hawa (4):
  iommu/arm-smmu: introduce wrapper for writeq/readq
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743
  dt-bindings: iommu/arm,smmu: add compatible string for Marvell
  arm64: dts: marvell: add smmu node for Armada-AP806

 Documentation/arm64/silicon-errata.txt             |  2 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 18 ++++++
 drivers/iommu/arm-smmu.c                           | 65 ++++++++++++++++++----
 4 files changed, 75 insertions(+), 11 deletions(-)

-- 
1.9.1

