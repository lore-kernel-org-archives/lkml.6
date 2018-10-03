Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213802098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uMUJ4FJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213802098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJCSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:08:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:08:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w93BIXnS104740;
        Wed, 3 Oct 2018 11:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2018-07-02;
 bh=TqeilqPwq4z5YIWZUODyPGsRIUPIqVRpjTVQpzOwNs0=;
 b=uMUJ4FJpy9CjDquiq8cUT/twK3Lij2L9s92dzRR/X1ZtN8/pqmN8DlBc0h/VVhG9afMd
 j6ex70Maqi7lSl8lidSeLfLTz8vqWQbBnR2OT0/GHqWCx/GgMCUP2Yt80cOm8bWUkQ7w
 tv3XlkNJYXUtMdtnLDtvqgchU3j9CBJRx4OWIARAChbyIrOBaLK/UvQFsCoKDxENDcUN
 GGftcumxNF/ZYqIrOtNsSviswzercdcGgx3d1Z5k+ybTgKoAVED60r/zmqZrd7BTMazD
 0UPgJVxngv4z6XnBR87SVZmhppe/5d9OBuQYQZRXTFwd0Wuny/l+3hyjDW/e+dQ4IcBG wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mt0ttu818-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Oct 2018 11:20:56 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w93BKnFi013607
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Oct 2018 11:20:49 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w93BKm4k020832;
        Wed, 3 Oct 2018 11:20:48 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Oct 2018 11:20:47 +0000
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Bug introduced by commit ebeeb1ad9b8a
Message-Id: <8EEB4CE2-F6E5-4128-AB04-6326F8315E31@oracle.com>
Date:   Wed, 3 Oct 2018 13:20:44 +0200
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        netdev@vger.kernel.or,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Yanjun Zhu <yanjun.zhu@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9034 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810030113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


I hope you will find this note appropriate.

The stable cherry-pick of upstream commit ebeeb1ad9b8a ("rds: tcp: use =
rds_destroy_pending() to synchronize netns/module teardown and rds =
connection/workq management") provokes the following stack trace when =
running with debug:


kernel: BUG: sleeping function called from invalid context at =
kernel/locking/mutex.c:748
kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
kernel: in_atomic(): 1, irqs_disabled(): 0, pid: 4392, name: rds-stress
kernel: 1 lock held by rds-stress/4392:
kernel: #0: 00000000df837d5e
kernel: WARNING: suspicious RCU usage
kernel: 4.18.8 #1 Not tainted
kernel: -----------------------------
kernel: ./include/linux/rcupdate.h:303 Illegal context switch in RCU =
read-side critical section!
kernel: (
kernel: #012other info that might help us debug this:
kernel: #012rcu_scheduler_active =3D 2, debug_locks =3D 1
kernel: rcu_read_lock){....}
kernel: 1 lock held by rds-stress/4393:
kernel: #0:
kernel: , at: __rds_conn_create+0x604/0x960 [rds]
kernel: 00000000df837d5e
kernel: CPU: 38 PID: 4392 Comm: rds-stress Not tainted 4.18.8 #1
kernel: Hardware name: Oracle Corporation ORACLE SERVER X5-2L/ASM,MOBO =
TRAY,2U, BIOS 31110000 03/03/2017
kernel: (rcu_read_lock
kernel: Call Trace:
kernel: ){....}
kernel: dump_stack+0x81/0xb8
kernel: , at: __rds_conn_create+0x604/0x960 [rds]
kernel: #012stack backtrace:
kernel: ___might_sleep+0x239/0x260
kernel: __might_sleep+0x4a/0x80
kernel: __mutex_lock+0x58/0x9c0
kernel: ? __lock_acquire+0x47f/0x7e0
kernel: ? pcpu_alloc+0x429/0x860
kernel: ? find_held_lock+0x40/0xb0
kernel: ? create_object+0x22f/0x320
kernel: ? _raw_write_unlock_irqrestore+0x36/0x60
kernel: mutex_lock_killable_nested+0x1b/0x20
kernel: pcpu_alloc+0x429/0x860
kernel: ? create_object+0x22f/0x320
kernel: __alloc_percpu+0x15/0x20
kernel: rds_ib_recv_alloc_cache+0x1c/0x80 [rds_rdma]
kernel: rds_ib_recv_alloc_caches+0x1d/0x60 [rds_rdma]
kernel: rds_ib_conn_alloc+0x46/0x170 [rds_rdma]
kernel: __rds_conn_create+0x68d/0x960 [rds]
kernel: ? __rds_conn_create+0x604/0x960 [rds]
kernel: rds_conn_create_outgoing+0x14/0x20 [rds]
kernel: rds_sendmsg+0x2e8/0xcd0 [rds]
kernel: ? copy_msghdr_from_user+0xdb/0x140
kernel: sock_sendmsg+0x38/0x50
kernel: ___sys_sendmsg+0x27b/0x290
kernel: ? __lock_acquire+0x47f/0x7e0
kernel: ? find_held_lock+0x40/0xb0
kernel: ? __audit_syscall_entry+0xdf/0x160
kernel: ? ktime_get_coarse_real_ts64+0x6e/0xe0
kernel: ? trace_hardirqs_on_caller+0x128/0x1b0
kernel: ? trace_hardirqs_on+0xd/0x10
kernel: ? __audit_syscall_entry+0xdf/0x160
kernel: ? __audit_syscall_entry+0xdf/0x160
kernel: __sys_sendmsg+0x5d/0xb0
kernel: __x64_sys_sendmsg+0x1f/0x30
kernel: do_syscall_64+0x5f/0x220
kernel: entry_SYSCALL_64_after_hwframe+0x49/0xbe

Command line:

$ rds-stress -r <IB port 1 IP>& sleep 1; rds-stress -r <IB port 2 IP> -s =
<IB port 1 IP> -T 10

Deliberately or accidently, Ka-Cheong's commit f394ad28feff ("rds: =
rds_ib_recv_alloc_cache() should call alloc_percpu_gfp() instead") fixes =
the bug introduced by commit ebeeb1ad9b8a. Kudos to Zhu Yanjun who =
quickly detected this.

But be aware, commit f394ad28feff does not contain the "Fixes:" tag.

Hence, I suggest that in all stable releases containing commit =
ebeeb1ad9b8a, f394ad28feff must be included as well.


Thxs, H=C3=A5kon







