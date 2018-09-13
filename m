Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74520861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XtVyB8cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeIMRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:05:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59504 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeIMRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:05:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8DBsHWv104767;
        Thu, 13 Sep 2018 11:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2018-07-02;
 bh=kXHGCbQXo/Yw4gZCw6yuyF4hU1NgiVffUvQ9Gg9tXQs=;
 b=XtVyB8cENyNbLNsvJ1iYLxljKS30uidf5ECDwiaRFKOmdsJriEuO6D/t5JU8dDt4Gese
 ZyjY9dXy9ZbnSzN5ZVwS19DcYdyOZIoKK8pGubnKnkeDnviKBWPB4nSdvslS9KLD4R61
 InebAFwxBGZZMmY4r9gkBpLjZMCRn1RbnK1SyeDDlsbnwm5MM2lGTU0TS9zDb8Un/5++
 r4Tj+3dfHYcBBIoKnfADoiYZjcKaotnw9FxkW+LDcie6uVtqd1FBZCbBNGWCNxmzvM6R
 NgDWcPtKn1d3BoLSBvzAv3e++qf9zjfIyP24TZA8RXp7eZBYmTcjFQCN5RS20w9eAYjA eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5uts0cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 11:55:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8DBtmR9030684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 11:55:48 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8DBtmcA006263;
        Thu, 13 Sep 2018 11:55:48 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 04:55:47 -0700
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: mutex and rcu list traversal idiosyncrasy
Message-Id: <E4626316-0683-45DF-9F09-D602FC982E21@oracle.com>
Date:   Thu, 13 Sep 2018 13:55:44 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        anjali.singhai@intel.com,
        Shannon Nelson <shannon.nelson@oracle.com>
To:     faisal.latif@intel.com, shiraz.saleem@intel.com
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=343
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809130122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faisal,


In commit f27b4746f378 ("i40iw: add connection management code") you =
have in i40iw_add_mqh_6():

rtnl_lock();
for_each_netdev_rcu(...) {
	[]
}
rtnl_unlock();

Shouldn't this read:

rtnl_lock();
for_each_netdev(...) {
	[]
}
rtnl_unlock();

or

rcu_read_lock();
for_each_netdev_rcu(...) {
	[]
}
rcu_read_unlock();


?



Thx, H=C3=A5kon


