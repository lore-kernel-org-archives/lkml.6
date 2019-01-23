Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0054520870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kW1i0yEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfAWPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:05:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAWPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:05:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NExZFU109200;
        Wed, 23 Jan 2019 15:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wqvT8Wb+W0AmbwGKCCcaLqdACPOdE/nTR7hWf9yNQnA=;
 b=kW1i0yEg7/5XZxmKxsmebigFyBfig/VaSmJkqufYV8/AhDkZI7IVM7k9s79hol9TmuGV
 n7LQE+Sd+/IPFJ6fxKk+EgVxb48Z0jiqgDusozkFYJRWHU4KimO62xA+Y3M7PWk9T6DK
 iZemFqNOJ0xdcdm22vdquEsUpYC1tEuaSL6I0HEuKKGlTHesL2XHlylumYaAd2M9ZUhH
 3p736MsLh4xgVU6MAHu0cvt5hEE/RFNk9Tgxs1fWxWQI2zrRg5JQTNL5J3w7YCgs+e8c
 IbGshnhlJAbrGvWye57ct1cg15XtGg2ngG7rEa5+isdYshsRLZdFzGX7tdDu0u4eGV9W jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q3vhrt8ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 15:04:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NF4Hm8000923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 15:04:17 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NF4FQw028179;
        Wed, 23 Jan 2019 15:04:15 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 07:04:15 -0800
Date:   Wed, 23 Jan 2019 10:03:36 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        Tycho Andersen <tycho@docker.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [RFC PATCH v7 09/16] mm: add a user_virt_to_phys symbol
Message-ID: <20190123150248.GE19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <c9a409397fc608f7ae6297597d9ea3d21eeb3b38.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a409397fc608f7ae6297597d9ea3d21eeb3b38.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL(user_virt_to_phys);

Could it be _GPL? OTherwise looks OK to me.
