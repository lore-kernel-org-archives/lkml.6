Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA37217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/s1vsrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfBZUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:00:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBZUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:00:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QJtKq6036989;
        Tue, 26 Feb 2019 20:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=lLUIu/rmkd8/hCZskxBfMuasSyFF1UtBaSpY+IOLxEg=;
 b=i/s1vsrEXQRY4oaj/vvoYr49GHgTsjhzGV/rGLzUEMkYwuWGnG0O8ymjBjPiEnFqLPBD
 uvQ19DdJeRS751VL5PDB9ffLB7Qdfw56wGUO1fecXVD5pXRSHshTtuZZ2OXu0f3U1eMG
 p0C87SvVvSplt4ZaeyCaFRNLUcfBkCXkOkeqm+AbxOV8uGT68N0VNKGLvBPzNAbmmvqW
 UK+ieubIukOaSDSqDu8mB4TXaGYr/RBUTBUui4q19gc4jEbo6rH29vWAvcwfQ2aCxByN
 bAI41PKuYMavNHRQmenyL0imWiE1qKMMcJjYaww+kL/izJdufVgFnAEMv2mxN+XFgiXt bg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qtwku6vpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 20:00:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1QK0Prk032318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 20:00:25 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1QK0L7R003455;
        Tue, 26 Feb 2019 20:00:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 12:00:21 -0800
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
        <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
        <yq1ftsad2yi.fsf@oracle.com>
        <b7f37c2d-27c7-9b58-20c8-52624783a6fa@free.fr>
        <yq1bm2yd2kr.fsf@oracle.com>
        <026c10b1-48e8-ab9f-fda8-6e3557b841a7@free.fr>
        <yq1y362bjnw.fsf@oracle.com>
        <8fc2eed2-f94b-8d43-6ca4-86e18f600997@free.fr>
Date:   Tue, 26 Feb 2019 15:00:17 -0500
In-Reply-To: <8fc2eed2-f94b-8d43-6ca4-86e18f600997@free.fr> (Marc Gonzalez's
        message of "Tue, 26 Feb 2019 18:02:18 +0100")
Message-ID: <yq1lg22b9ri.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=439 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

> The resolution is simple: we keep the HEAD version, and simply remove
> ufshcd_set_vccq_rail_unused() and its error-handling.
>
>
> Is that the information you were after?

Yes.

> Do you prefer the patch subject to be:
> Revert "scsi: ufs: disable vccq if it's not needed by UFS device"
> instead of:
> scsi: ufs: Do not disable vccq in UFSHC driver
>
> And I should leave in the automatically added
> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
> while adding some information from the manual resolution?

Exactly.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
