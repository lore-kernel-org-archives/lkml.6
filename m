Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21CEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D02075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43D02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIGE72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:59:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58111 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeIGE72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:59:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fy4WZ-00057W-OL; Fri, 07 Sep 2018 01:21:23 +0100
Message-ID: <1536279682.3024.95.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 105/124] xen-netfront: wait xenbus state change when
 load module manually
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Sep 2018 01:21:22 +0100
In-Reply-To: <20180804082706.393252081@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082706.393252081@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 11:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Xiao Liang <xiliang@redhat.com>
> 
> [ Upstream commit 822fb18a82abaf4ee7058793d95d340f5dab7bfc ]
> 
> When loading module manually, after call xenbus_switch_state to initializes
> the state of the netfront device, the driver state did not change so fast
> that may lead no dev created in latest kernel. This patch adds wait to make
> sure xenbus knows the driver is not in closed/unknown state.
[...]
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -86,6 +86,7 @@ struct netfront_cb {
>  /* IRQ name is queue name with "-tx" or "-rx" appended */
>  #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
>  
> +static DECLARE_WAIT_QUEUE_HEAD(module_load_q);
>  static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
>  
>  struct netfront_stats {
> @@ -1335,6 +1336,11 @@ static struct net_device *xennet_create_
>  	netif_carrier_off(netdev);
>  
>  	xenbus_switch_state(dev, XenbusStateInitialising);
> +	wait_event(module_load_q,
> +			   xenbus_read_driver_state(dev->otherend) !=
> +			   XenbusStateClosed &&
> +			   xenbus_read_driver_state(dev->otherend) !=
> +			   XenbusStateUnknown);
>  	return netdev;
>  
>   exit:

This won't work; it will hang.  Something (maybe netback_changed()?)
needs to wake up tasks on the module_load_q.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
