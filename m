Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5D20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vLcvEhWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfBZOxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:53:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBZOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:53:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QEYOfI133837;
        Tue, 26 Feb 2019 14:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8f2troXZJlIRoFZoRTOejDzBF5H0+spueZgXsxCsY50=;
 b=vLcvEhWNJy5zjzJAW+9O8b6Qi7OH5r8vV82AURbBACwIOlhNSI53+im4NJJ7BJYiiIt6
 3hnLbPtzpGwCkFJPyTUSz/kx3ljvtXkc/dqMlWweVMEnvfQ86M2VgHGf3IDYNVBJWfpY
 7BryiQwY4NUbuv7LX482W7ODf155Bl1Dmle1BToFLVPps+myWGoXaaN46Y4s1Jak021Z
 neEOTxBOHoI/23VKJpoCYFaVZOiQ4Uj9VvUQuSG1HqqQ/jgz0bOMQsztmS5LO8aYyIit
 osndhnC84yxAhflgzsh3E75bVZfjyilPEHYB8zuALvAiG2qX4UVhAXiJxwkVBUfvvtHr zA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qtupe57u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 14:52:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1QEqgsk008214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 14:52:43 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1QEqfJx014987;
        Tue, 26 Feb 2019 14:52:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 06:52:40 -0800
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
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
        <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
        <yq1ftsad2yi.fsf@oracle.com>
        <b7f37c2d-27c7-9b58-20c8-52624783a6fa@free.fr>
Date:   Tue, 26 Feb 2019 09:52:36 -0500
In-Reply-To: <b7f37c2d-27c7-9b58-20c8-52624783a6fa@free.fr> (Marc Gonzalez's
        message of "Tue, 26 Feb 2019 15:45:58 +0100")
Message-ID: <yq1bm2yd2kr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=760 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

>>> Revert the original patch, and clean up loose ends in the next patch.
>> 
>> This commit isn't a revert. Why not?
>
> What do you mean?

Your commit states it reverts the original patch but the submission is
not a git revert. If there are reasons why simply reverting the original
commit didn't work, I'd like to see them documented in the commit
message.

-- 
Martin K. Petersen	Oracle Linux Engineering
