Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933321AbeD1BvI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 21:51:08 -0400
Received: from la.guarana.org ([173.254.219.205]:59832 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933263AbeD1BvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 21:51:06 -0400
Date: Fri, 27 Apr 2018 21:51:06 -0400
From: Kevin Easton <kevin@guarana.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] vhost: Use kzalloc() to allocate vhost_msg_node
Message-ID: <20180428015106.GA27738@la.guarana.org>
References: <000000000000a5b2b1056a86e98c@google.com>
 <20180427154502.GA22544@la.guarana.org>
 <20180427185501-mutt-send-email-mst@kernel.org>
 <20180428010756.GA27341@la.guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428010756.GA27341@la.guarana.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 09:07:56PM -0400, Kevin Easton wrote:
> On Fri, Apr 27, 2018 at 07:05:45PM +0300, Michael S. Tsirkin wrote:
> > On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
> > > The struct vhost_msg within struct vhost_msg_node is copied to userspace,
> > > so it should be allocated with kzalloc() to ensure all structure padding
> > > is zeroed.
> > > 
> > > Signed-off-by: Kevin Easton <kevin@guarana.org>
> > > Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
> > 
> > Does it help if a patch naming the padding is applied,
> > and then we init just the relevant field?
> > Just curious.
> 
> No, I don't believe that is sufficient to fix the problem.

Scratch that, somehow I missed the "..and then we init just the
relevant field" part, sorry.

There's still the padding after the vhost_iotlb_msg to consider.  It's
named in the union but I don't think that's guaranteed to be initialised
when the iotlb member of the union is used to initialise things.

> I didn't name the padding in my original patch because I wasn't sure
> if the padding actually exists on 32 bit architectures?

This might still be a concern, too?

At the end of the day, zeroing 96 bytes (the full size of vhost_msg_node)
is pretty quick.

    - Kevin
