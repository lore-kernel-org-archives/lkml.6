Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D84218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D84218F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeHQMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:41:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbeHQMlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 239FF26A40;
        Fri, 17 Aug 2018 09:38:39 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3B7E2156712;
        Fri, 17 Aug 2018 09:38:33 +0000 (UTC)
Date:   Fri, 17 Aug 2018 11:38:30 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v9 18/22] s390: vfio-ap: implement VFIO_DEVICE_RESET
 ioctl
Message-ID: <20180817113830.250a4285.cohuck@redhat.com>
In-Reply-To: <4bcf1214-1978-aa11-ca22-7ab4352dacfb@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-19-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180815183835.66470bc6.cohuck@redhat.com>
        <4bcf1214-1978-aa11-ca22-7ab4352dacfb@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 17 Aug 2018 09:38:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 17 Aug 2018 09:38:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 17:05:48 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/15/2018 12:38 PM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:15 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +	case VFIO_DEVICE_RESET:
> >> +		ret = vfio_ap_mdev_reset_queues(mdev, true);  
> > If I see it correctly, you call this function only ever with force ==
> > true (here and in the previous patch). Is that what you intended?  
> 
> That does seem to be the case now; however, I think at one time there were
> additional calls to this function. For some reason of which I am not aware,
> those were removed, so there is probably no need for it now.

If you don't see a need for it anymore, I'd just remove the parameter.
Even makes vfio_ap_mdev_reset_queues() a bit nicer :)
