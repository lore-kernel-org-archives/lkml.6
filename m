Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B782081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tckfAn5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B782081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLDOt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:49:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59656 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeLDOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:49:27 -0500
X-Greylist: delayed 3096 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 09:49:26 EST
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4DuxMJ109167;
        Tue, 4 Dec 2018 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gczuXyUseXDrTfD2ZrIZWHkPtd/+Oj/ymxNKyMoJnPE=;
 b=tckfAn5CHau5R+I9GwWTxskAo4RRup/4kiLdGRjRwgpFFSrfwelcZ2pNdH3e6wj8Qt/W
 rRdrg5OCtIXlg/VP7aO7ME2iEAhdXcV4YGqGuPRWm00dXlySXNqZrM+xUP2+67uIFz/c
 rcotESMNwXa4/7Y+7YrpODNo1XM4OpUTJzjO0Eu7p1JYc/aYu+dD12jKbqhwn1kXHCRG
 S+PesokacOZ+c2VnTnFEYx3Mz83Tdo7u2m/8SWmtBlI/Gfy4f/8KfCmQxCHr832JJMm6
 wYbWDq4OG9JC4e7zCP6Nh1mK3QDiYoTe3QhaQMnx8xaciFNUrW8ekIGYOTHEcPu0EgCa Uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf0ewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 13:57:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4DvSZr029522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 13:57:28 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB4DvQKw028588;
        Tue, 4 Dec 2018 13:57:26 GMT
Received: from [10.191.25.55] (/10.191.25.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 05:57:26 -0800
Subject: Re: Compiling with old gcc breaks when CONFIG_RETPOLINE is off
To:     Meelis Roos <mroos@linux.ee>, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, yamada.masahiro@socionext.com
References: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <5e7dfdc9-8680-91f6-4d7e-aa14fbb6def8@oracle.com>
Date:   Tue, 4 Dec 2018 21:57:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit '315bab4e972d kbuild: fix endless syncconfig in case arch 
Makefile sets CROSS_COMPILE',

arch/$(SRCARCH)/Makefile is moved ahead of include/config/%.conf 
synchonization in root Makefile.

So all the CONFIG_* option used in arch/$(SRCARCH)/Makefile may have 
stale value if they were just updated in .config.

This looks like an issue. I'm not familiar with kbuild. Ccing Yamada for 
help.


Thanks

Zhenzhong

On 2018/12/4 17:58, Meelis Roos wrote:
> Just tried 4.20-rc5 on an old K6-2 PC with gcc 5.3.1, got an error 
> about non-retpoline compiler,
> turned CONFIG_RETPOLINE off and retried.
>
> To my surprise, compilation still breaks with
> arch/x86/Makefile:224: *** You are building kernel with non-retpoline 
> compiler, please update your compiler..  Stop.
>
> As I read the Makefile, it should error only when CONFIG_RETPOLINE is 
> enabled, but it still breaks.
>
> $ grep -r CONFIG_RETPOLINE .config
> # CONFIG_RETPOLINE is not set
>
> $ grep -r CONFIG_RETPOLINE include/
> include/generated/autoconf.h:#define CONFIG_RETPOLINE 1
> include/config/auto.conf:CONFIG_RETPOLINE=y
>
> So the headers have not been updated yet, maybe?
>
