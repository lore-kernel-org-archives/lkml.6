Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeDNWbZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 18:31:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751946AbeDNWbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 18:31:24 -0400
Date: Sun, 15 Apr 2018 00:31:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Laura Abbott <labbott@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: Regression with 5dcd8400884c ("macsec: missing dev_put() on
 error in macsec_newlink()")
Message-ID: <20180414223121.GA7475@bistromath.localdomain>
References: <9a3a84ff-1fd1-c063-0c50-a297d29a692b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a3a84ff-1fd1-c063-0c50-a297d29a692b@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laura,

2018-04-14, 10:56:55 -0700, Laura Abbott wrote:
> Hi,
> 
> Fedora got a bug report of a regression when trying to remove the
> the macsec module (https://bugzilla.redhat.com/show_bug.cgi?id=1566410).
> I did a bisect and found
> 
> commit 5dcd8400884cc4a043a6d4617e042489e5d566a9
> Author: Dan Carpenter <dan.carpenter@oracle.com>
> Date:   Wed Mar 21 11:09:01 2018 +0300
> 
>     macsec: missing dev_put() on error in macsec_newlink()
>     We moved the dev_hold(real_dev); call earlier in the function but forgot
>     to update the error paths.
>     Fixes: 0759e552bce7 ("macsec: fix negative refcnt on parent link")
>     Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> The script I used for testing based on the reporter is attached. It
> looks like modprobe is stuck in the D state. Any idea?

I don't think that reference was actually leaked. It gets released in
macsec_free_netdev() when the device is deleted.

modprobe getting stuck is just a side-effect of the refcount going
negative on the parent device, since removing the module needs to take
the lock that is held by device deletion.

I'll send a revert tomorrow.

Thanks for the report,

-- 
Sabrina
