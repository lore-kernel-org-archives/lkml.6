Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeC0J2Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:28:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeC0J2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:28:22 -0400
Date: Tue, 27 Mar 2018 10:28:11 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: correctly remove wait queue during poll
 failure
Message-ID: <20180327092811.ikvssyxgb74nucb4@dhcp-10-175-199-170.vpn.oracle.com>
Mail-Followup-To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1522122442-30317-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1522122442-30317-1-git-send-email-jasowang@redhat.com>
User-Agent: NeoMutt/20180223
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Mar 27, 2018 at 11:47:22AM +0800, Jason Wang wrote:
>We tried to remove vq poll from wait queue, but do not check whether
>or not it was in a list before. This will lead double free. Fixing
>this by checking poll->wqh to make sure it was in a list.

This text seems at odds with the code below, instead of checking
poll-whq, you are removing that check...

Maybe the text needs rewording?

Thanks,

Darren.

>
>Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
>Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 1b3e8d2d..5d5a9d9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -212,8 +212,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
> 	if (mask)
> 		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
> 	if (mask & EPOLLERR) {
>-		if (poll->wqh)
>-			remove_wait_queue(poll->wqh, &poll->wait);
>+		vhost_poll_stop(poll);
> 		ret = -EINVAL;
> 	}
>
>-- 
>2.7.4
>
