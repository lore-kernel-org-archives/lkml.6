Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532DC2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v7kZsaJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBZQ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:26:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:26:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QGQNoE047576;
        Tue, 26 Feb 2019 16:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bC31bQBKPyqDLsVM8GDL28ohBFYeO0xaxjLww1TLyR0=;
 b=v7kZsaJnblQrUN4x2fqJxP4vQf3fLidTXPd0KjkIfTc7ZVg8HUn0/E4LRBHg2+ywsQ56
 hUi22LJyYgh+tfRL6aQA9Th5EyAk19A9vUYDWG/tGRDhB86njtbZTfjwnIh/pohetrFL
 scj9BBOCoSVSsbZdcTiHaRQXx++KCk9MPRtkUUVxn91zHyipTE52irJpFaitu3EKvBZy
 3CEhurE8vtjb8aOsi1P6W7bDZLNZ6TnH+YdalLZbt6zNcahA8KBA98IEpV925mwMqgIK
 VlzfXyagPxkgVeCK8F0toKoVh1auMQZs5bVLcMjkUbXdVAwgmuLZFAtREvcHUxHCdOPz +w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwku5ptx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 16:26:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1QGQcM5022745
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 16:26:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1QGQZkL010710;
        Tue, 26 Feb 2019 16:26:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 08:26:35 -0800
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
Date:   Tue, 26 Feb 2019 11:26:27 -0500
In-Reply-To: <026c10b1-48e8-ab9f-fda8-6e3557b841a7@free.fr> (Marc Gonzalez's
        message of "Tue, 26 Feb 2019 16:30:09 +0100")
Message-ID: <yq1y362bjnw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

> I indeed started off from 'git revert'
>
> $ git revert 60f0187031c0
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at
> least 18258 and retry the command.
> error: could not revert 60f0187031c0... scsi: ufs: disable vccq if
> it's not needed by UFS device
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
>
> So I had to resolve the conflict in ufshcd_probe_hba()
>
> The line:
>
> 	ufs_advertise_fixup_device(hba);
>
> was modified by commit 93fdd5ac64bbe80dac6416f048405362d7ef0945

If it's a resolvable delta, a proper git revert is preferred. Please
document any conflicts in the commit message and list the relevant
commits that introduced them.

If you find yourself in a situation where reverting simply isn't
feasible, I'd expect the commit to state "This should have been a revert
but I'd have to boil the oceans to resolve the conflicts because XYZ..."

-- 
Martin K. Petersen	Oracle Linux Engineering
