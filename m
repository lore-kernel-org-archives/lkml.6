Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14CE6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21D1208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPQuqyx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21D1208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeFLNHN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:07:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeFLNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:07:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CD5pTq055581;
        Tue, 12 Jun 2018 13:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=UUm+W5ESBxjDE8tlS7C65IEZY9wItHfnI//bDRgp6Uk=;
 b=dPQuqyx8RPEZgiGs303POlG/0UCZBWjh95FaNYQfJtUjyTe7kmh2dN01caa4dnf6w4Jj
 VMpUAKvr6E8D+S12h4iiP8sMkzUu3MqcnwsF0trLrqKMyNlUP54x4S8MTIBJ2XWolG+Y
 ckMpRoT7Rgct1LTTii0CGh+GmtNj9ozG99H9EfyDPxcEpzqfWIp4Z3ZEsdCGlNV9CuYw
 AecouIGBZgtUxHXrHyK90hFz962eniyWh+nYM08xbdm8hGc7Wn+Y1HVmm911hQ80u607
 M8TQtSQkICqyJ37cMQna9RUdfT3uUyufkitv3q8tlLQjb51xiW47HE4DEe1soW/ZpKGl CQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jg6b1hx87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 13:06:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CD6p9G007369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 13:06:52 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CD6nQO005115;
        Tue, 12 Jun 2018 13:06:50 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 06:06:49 -0700
Date:   Tue, 12 Jun 2018 16:06:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>, devel@driverdev.osuosl.org,
        ldv-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: Re: [PATCH] staging: rts5208: add check on NULL before dereference
Message-ID: <20180612130640.6lcnn4cj7cval7aw@mwanda>
References: <20180609163829.30619-1-vasilyev@ispras.ru>
 <ddb00f65153abf3dfe81d9da86c9b98c@codeaurora.org>
 <CAHp75VdkDCCJCqBTGsPCzaCKfT_bqYNGDQekvr56U3fhR+uthA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdkDCCJCqBTGsPCzaCKfT_bqYNGDQekvr56U3fhR+uthA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=52 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 10:34:43PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 9, 2018 at 7:58 PM,  <okaya@codeaurora.org> wrote:
> > On 2018-06-09 12:38, Anton Vasilyev wrote:
> >>
> >> If rtsx_probe fails to allocate dev->chip, then NULL pointer
> >> dereference occurs at rtsx_release_resources().
> >>
> >> Patch adds checks chip on NULL before its dereference at
> >> rtsx_release_resources and passing with dereference inside
> >> rtsx_release_chip.
> >>
> >> Found by Linux Driver Verification project (linuxtesting.org).
> 
> > I think you should bail out if dev->chip is null rather than adding
> > conditiinals.
> 
> I'm wondering if it's false positive. At which circumstances that may happen?
> 


Here's how the code looks like in rtsx_probe().

   972          /* We come here if there are any problems */
   973  errout:
   974          dev_err(&pci->dev, "%s failed\n", __func__);
   975          release_everything(dev);
   976  
   977          return err;
   978  }

Do everything error handling is error prone because you're trying to
free some things which haven't been allocated.  It's also more
complicated so it leads to leaks.

The correct way to do error handling is to have a series of labels which
undo one thing at a time.  The labels should be named properly so that
you can tell what the goto does such as "goto err_release_foo;".  That
way you never have to worry about freeing things which haven't been
allocated.  As you read the code, you just have to track the most
recently allocated resource and verify that the goto does what is
expected so you avoid leaks.

In this example:

   857          dev->chip = kzalloc(sizeof(*dev->chip), GFP_KERNEL);
   858          if (!dev->chip) {
   859                  err = -ENOMEM;
   860                  goto errout;
   861          }
   862  
   863          spin_lock_init(&dev->reg_lock);
   864          mutex_init(&dev->dev_mutex);
   865          init_completion(&dev->cmnd_ready);
   866          init_completion(&dev->control_exit);
   867          init_completion(&dev->polling_exit);
   868          init_completion(&dev->notify);
   869          init_completion(&dev->scanning_done);
   870          init_waitqueue_head(&dev->delay_wait);

If the kzalloc() fails, then we call release_everything() with
"dev->chip" NULL.  But we'll actually crash before we hit the NULL
dereference because we didn't do the init_completion(&dev->cmnd_ready);

So this patch doesn't really fix anything because do everything error
handling is a hopeless approach.

regards,
dan carpenter
