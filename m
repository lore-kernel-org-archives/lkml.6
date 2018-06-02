Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeFBEyc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 00:54:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750748AbeFBEya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 00:54:30 -0400
Date: Sat, 2 Jun 2018 12:54:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Bart.VanAssche@wdc.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, alan.christopher.jenkins@gmail.com,
        syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com,
        martin.petersen@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        oleksandr@natalenko.name, martin@lichtvoll.de, hare@suse.com,
        syzkaller-bugs@googlegroups.com, ross.zwisler@linux.intel.com,
        keith.busch@intel.com, linux-ext4@vger.kernel.org
Subject: Re: INFO: task hung in blk_queue_enter
Message-ID: <20180602045353.GA20257@ming.t460p>
References: <CACT4Y+ZJwvROpBmKWF08fTd2AH=dO-a5+dzCzZua_vVFjiCRBw@mail.gmail.com>
 <6db16aa3a7c56b6dcca2d10b4e100a780c740081.camel@wdc.com>
 <201805220652.BFH82351.SMQFFOJOtFOVLH@I-love.SAKURA.ne.jp>
 <201805222020.FEJ82897.OFtJMFHOVLQOSF@I-love.SAKURA.ne.jp>
 <25708e84-6f35-04c3-a2e4-6854f0ed9e78@I-love.SAKURA.ne.jp>
 <dc9862c7-ec16-8b11-04e4-422b435d41ef@kernel.dk>
 <20180601234946.GA655@ming.t460p>
 <95c419d8-7f19-f9c0-a53f-3d381fe93176@kernel.dk>
 <20180602023622.GA2306@ming.t460p>
 <f43465cf-e2f1-807f-d283-89033c056b5b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43465cf-e2f1-807f-d283-89033c056b5b@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:31:13PM -0600, Jens Axboe wrote:
> On 6/1/18 8:36 PM, Ming Lei wrote:
> >> clear the bit when we need to, potentially even adding a debug check to
> >> blk_queue_enter_live() that complains if the ref was not already
> >> elevated. Though that would be expensive, compared to the percpu inc
> >> now. Not saying the bit is necessarily the best way forward, but I do
> >> like it a LOT more than adding an argument to generic_make_request.
> > 
> > We may introduce generic_make_request_with_ref() for blk_queue_split(),
> > what do you think of the following patch?
> 
> Functionally it'll work as well.

If you are fine with this one, I'm glad to prepare for a normal one,
so that we can save one precious bio flag, and the total number is
just 13.

> 
> > In DM or MD, there is the following use case:
> > 
> > 1) bio comes from fs, then one clone is made from this bio
> > 
> > 2) the cloned bio is submitted via generic_make_request() from
> > another context, such as wq.
> > 
> > 3) then the flag of BIO_QUEUE_ENTERED is inherited and causes
> > the queue usage counter isn't held.
> 
> We don't copy flags on a clone.

Yeah, you are right, seems I ignored that.

Thanks,
Ming
