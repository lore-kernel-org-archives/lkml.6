Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075E420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNfy2h0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075E420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeGWSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:41:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbeGWSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:41:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NHYPcW150163;
        Mon, 23 Jul 2018 17:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ptOcfrI9q1XzseTyNaiyIMcfwpmN+9SgliSimjX/8TM=;
 b=YNfy2h0ATyDRlPsfw9R4owjyNLzydBaRM7frLcL1RVno17TIgjYo6rP0BW5Pwsbhsya9
 XcadrT6maK+pTJbNDLLthoKA2xK6ZDc8XKXJQYtIKlM2xxRV4j0cmaYh4Cc/UEXEUuZr
 klUF2ricw0QqgvP0grmeZMB2pRiq/iz2nXxG7mQdoGzsbCgrgEYi79a7wgX4LkXIdpX1
 e17UE1ppKKNdfKt78pv7ohcXp2NXYIRnttTFlWjgAmSD1/J96Y5WFnyV75IkMcC6U2pz
 IPpoDSYP2D5ptRL2J7qj1mlta+bROpjyC3jUWrb1vrAVfTpG+0p4H975LDRHuBL56TNV 7w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kbv8swmqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 17:39:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6NHd1h1020346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 17:39:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6NHd1BV020536;
        Mon, 23 Jul 2018 17:39:01 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 10:39:00 -0700
Subject: Re: KASAN: use-after-free Read in rds_cong_queue_updates (2)
To:     syzbot <syzbot+470ae97a39f16146af45@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
References: <000000000000cdb5450571adfe40@google.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <ed11f25c-6e61-16c2-2ac0-e3196c32ffb6@oracle.com>
Date:   Mon, 23 Jul 2018 10:38:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000cdb5450571adfe40@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=603
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 10:30 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    fcf4793e278e tls: check RCV_SHUTDOWN in tls_wait_data
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1738cb2c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0bdc4175608181c
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=470ae97a39f16146af45
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+470ae97a39f16146af45@syzkaller.appspotmail.com
> 
dup: syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com
