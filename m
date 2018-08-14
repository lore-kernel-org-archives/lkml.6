Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B759CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723062175C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llSOsxki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723062175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeHNMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:41:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:41:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7E9narO064228;
        Tue, 14 Aug 2018 09:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vJZtfz7nHhQY92LKJklEGH9/9//xX+nfu/dIgCmlWeg=;
 b=llSOsxki7PccIiOcgBMe2uf3HDhvd1zoNhD8mYl9iIb85uHFEsWJ4GryK9CJQrIU9nK9
 heVLMesKWDYYpNRdwNiVu5RAlSlsPRHDP8zpiUffBTMCG0/6RbNqq0Jbbj7MlBDTQZbS
 P8axs7Plrz2pJDlZpNaM5pIqlwgkbWMehyYkTsWImh7eeGkoG4Grz/u5FsxwE1dpoKiF
 HVkY7jKS4YWRak2ZRQrwfwWD2/9b1loDzUipxFOitrDLwLIuSMOyB73O74lKj9TR7zYS
 u2++zMUo0Vo3C7dc4tNGq+Qbgoj0eu9NOihgt8xofUQ92/CxuyTNpYpPX+fVfrCaMW1z 0A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ksqrp7st9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 09:54:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7E9sOLK016184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 09:54:24 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7E9sMQQ022020;
        Tue, 14 Aug 2018 09:54:23 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Aug 2018 02:54:22 -0700
Date:   Tue, 14 Aug 2018 12:54:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     security@kernel.org, kdeus@google.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
Message-ID: <20180814095413.vbjkcjkmytkffyaz@mwanda>
References: <20180813223910.26276-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813223910.26276-1-surenb@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8984 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=662
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808140102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  This is great.  I'm so glad these are finally getting fixed.

Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
(0x7f) so that's one element beyond the end of the array and the
NFC_HCI_HCP_RESPONSE isn't checked.

Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
NCI_HCP_MSG_GET_PIPE() so those could be off by one.

regards,
dan carpenter

