Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC502C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A52083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pmL2DdBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966108AbeFSKnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:43:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965437AbeFSKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:43:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JAd6g0013812;
        Tue, 19 Jun 2018 10:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=PLnTwibDMvwrb4/vFA7ZSZizdeLffb6NLX/biCmxmQA=;
 b=pmL2DdBFzMDTn/WmBCC8xWKLXXT4NSHWlOc/3v8dORXmDQCGJJlcIM80rLs2es8ngMnq
 cFp39d/DJcKp5YjC3ue4thCedSLtbrAkEzYtwmA6DEgzfHX3yz/W2NnEeqTsGCzXHOJ0
 o+DkO019xGZAJGLpfibN27OJbfbkG2/6NEHFUe1jtCb/Hb3yCJVPzrg9QwIcG55K9+k8
 a2N9Eij0eWBxu5+LbN8lAhBcl2zqikupI9MGU1K+YK/7O+aqHpz9K5Z3NBeyX8mJVrhq
 8VJYn2M982EhsfvYcO9s7wl8yVDHgexZBq91qpfBkYbXNmvRzuESszZau78G88MPYx8Q qQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jmtgwqk4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 10:43:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JAh4ga019714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 10:43:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JAh31m008252;
        Tue, 19 Jun 2018 10:43:03 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 03:43:02 -0700
Date:   Tue, 19 Jun 2018 13:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180619104248.z5nbbakwhjgscufb@mwanda>
References: <20180618022400.GA1893@hle-laptop.local>
 <20180618101838.gzbrxabilnqyilsi@mwanda>
 <20180619030850.GA1876@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619030850.GA1876@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=529
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:11:36PM -0400, Hugo Lefeuvre wrote:
> Hi Dan,
> 
> > We need to decrement device->users-- on the error paths as well.
> > This function was already slightly broken with respect to counting the
> > users, but let's not make it worse.
> > 
> > I think it's still a tiny bit racy because it's not an atomic type.
> 
> Oh right, I missed that. I'll fix it in the v2. :)
> 
> > I'm not sure the error handling in open() works either.  It's releasing
> > device->rx_buffer but there could be another user.
> 
> Agree.
> 
> > The ->rx_buffer
> > should be allocated in probe() instead of open() probably, no?  And then
> > freed in pi433_remove().  Then once we put that in the right layer
> > it means we can just get rid of ->users...
> 
> It would be great to get rid of this counter, indeed. But how to do it
> properly without breaking things ? It seems to be useful to me...

These things are refcounted so you can't unload the module while a file
is open.  When we do an open it does a cdev_get().  When we call the
delete_module syscall, it checks the refcount in try_stop_module() ->
try_release_module_ref().  It will still let us force a release but
at that point you're expecting use after frees.

> 
> For example, how do you handle the case where remove() is called but
> some operations are still running on existing fds ?
> 
> What if remove frees the rx_buffer while a read() call executes this ?
> 
> copy_to_user(buf, device->rx_buffer, bytes_received)
> 
> rx_buffer is freed by release() because it's the only buffer from the
> device structure used in read/write/ioctl, meaning that we can only
> free it when we are sure that it isn't used anywhere anymore.
> 
> So, we can't do it in remove() unless remove() is delayed until the
> last release() has returned.
> 
> > The lines:
> >
> >   1008                  if (!device->spi)
> >   1009                          kfree(device);
> >
> > make no sort of sense at all...  Fortunately it's not posssible for
> > device->spi to be NULL so it's dead code.
> 
> Really ? device->spi is NULL-ed in remove() so that operations on
> remaining fds can detect remove() was already called and free remaining
> resources:
>  
> 1296         /* make sure ops on existing fds can abort cleanly */
> 1297         device->spi = NULL;
> 
> Thanks for your time !

That's when we're unloading the module so there aren't any users left.

regards,
dan carpenter

