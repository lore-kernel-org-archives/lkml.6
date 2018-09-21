Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6713721522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXK9pifA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713721522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbeIUHqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:46:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:46:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L1xHoV059956;
        Fri, 21 Sep 2018 02:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=z4JnQk58Y/tIfPkoAmO5WF+OdZBPerBwyFBTFoCgcgE=;
 b=OXK9pifA/jqJtgCqrpccQ2Z3TkxPaH+GjYcf+ftp3N6xJ1/BXKOHTsuSKLmddgNDMf9L
 rTiDTfXrfmKQES19Zdkh0btvHgrJjKcE4kKod6mGa8O3xwEAgeAYESi2A7pVNsVR3icZ
 DsQUPdpqEsNrpvFs6nE+LNaZqcqb5aNlPiLGSFB3M8qC6eOqojAv5MIelFyLPNLbO5Dk
 zrh3leEU0NzbiasvgaJsOxj9lHROg9uJS70DYvq14HZsGjyXEXC41ZgVpnBqvLN4X0zC
 5WC92nxFuvSq07J1WtSd/xBOxPm04RCrbqtV0IODFxqZPeYi3CmNQvWfPL7KtoYkXEob hA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mmkm20kdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 02:00:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8L1xxHg027013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 01:59:59 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8L1xu2Y017428;
        Fri, 21 Sep 2018 01:59:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 18:59:56 -0700
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Janek Kotas <jank@cadence.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Li Wei <liwei213@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH RFC] scsi: ufs: Disable blk-mq for now
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180913112848.7807-1-adrian.hunter@intel.com>
Date:   Thu, 20 Sep 2018 21:59:49 -0400
In-Reply-To: <20180913112848.7807-1-adrian.hunter@intel.com> (Adrian Hunter's
        message of "Thu, 13 Sep 2018 14:28:48 +0300")
Message-ID: <yq1lg7vmwyy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=329
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian,

> blk-mq does not support runtime pm, so disable blk-mq support for now.

Applied to 4.19/scsi-fixes. Looking forward to getting this fixed up
properly in 4.20.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
