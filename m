Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D5ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243521479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jciZwzlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3243521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJTAYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:24:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJTAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:24:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JG9BcT129105;
        Fri, 19 Oct 2018 16:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lsGXcVsP1jI/WSaztb3O298BtOA+wvmb9dcxTMrXTSA=;
 b=jciZwzlTtXgwWQfm+bYWw6T1UAMJSII23s7Mm6AVRggf+caHDdTzi63dW1aoMADPNvCH
 ZDhieU5REmY64Pog2/7D0/iKRvNjTZtn4uvaIVVeaUHZ0mOsTfa3Nn2aMPY3tyrJhBci
 dO3DvSXF5RwsPPVCSwawmZR6M/fB4opjX4JbXRIjHzrTdJwHXAdm1cGqn39hxktCn9wy
 C+/Dr9twLl6ufTJC4nvZi1KfbxZUA+eYKAusphe8dI8+YXyuKL+qJRYTI+X7DM0tqyuu
 xBNibcNvHY/k0/E6HQ+tF+20nJTfnJU9IMdx4evoN1TWwlsJ10yp9TrDwizPlpBKKCZn 2Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384un6dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 16:17:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9JGHYt8006247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 16:17:35 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9JGHY24008444;
        Fri, 19 Oct 2018 16:17:34 GMT
Received: from [10.211.46.5] (/10.211.46.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 09:17:34 -0700
Subject: Re: [PATCH V2] xen-swiotlb: use actually allocated size on check
 physical continuous
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0453c762-1f8b-079f-5fdf-548e90909318@oracle.com>
 <20181018235219.GA36047@konrads-mbp.lan>
 <e476c3e8-d501-c5c6-d389-8b0b33adf4b1@oracle.com>
 <20181019134303.GC54336@Konrads-MacBook-Pro.local>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <09206a13-0fad-bfbd-062d-259f857b6a90@oracle.com>
Date:   Fri, 19 Oct 2018 09:17:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019134303.GC54336@Konrads-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 6:43 AM, Konrad Rzeszutek Wilk wrote:
> I will fold in the stack trace in later tonight. Thanks!

Thank you very much!
