Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161158AbeCATHo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:07:44 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:37074 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161068AbeCATHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:07:42 -0500
X-Google-Smtp-Source: AG47ELsLC0Cd7hn7Y7GbAVTOccNk47PlSAiPdOCjXUbD/f7ubhsK5HxZL+EWjNXtpbXz0CPYpcnfSV52CmuYI2gqxhg=
MIME-Version: 1.0
In-Reply-To: <20180301064018.kdy34jixrsmwossf@f1.synalogic.ca>
References: <20180228052006.12074-1-bpoirier@suse.com> <CAKgT0Uc_Dur56FxJfqoh90E=pUYtiKJr20f3fado-GdL8yUi5w@mail.gmail.com>
 <20180301064018.kdy34jixrsmwossf@f1.synalogic.ca>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Mar 2018 11:07:40 -0800
Message-ID: <CAKgT0Ueq8Wv7wQqxQR9EZmnhtPCuyW_tfP-HXvVrZFAXUEkwMw@mail.gmail.com>
Subject: Re: [PATCH] e1000e: Fix link status in case of error.
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:40 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> On 2018/02/28 08:48, Alexander Duyck wrote:
>> On Tue, Feb 27, 2018 at 9:20 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
>> > Before commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
>> > up"), errors which happen after "get_link_status = false" in the copper
>> > check_for_link callbacks would be ignored and the link considered up. After
>> > that commit, any error implies that the link is down. Since all
>> > combinations of link up/down and error/no error are possible, do the same
>> > thing as e1000e_phy_has_link_generic() and return the link status in a
>> > separate variable.
>> >
>> > Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
>> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
>>
>> This seems more like a refactor than a fix. There are valid cases
>> where errors can be ignored after we set the link to up. For example
>> if we cannot negotiate flow control we may not care as long as the
>> link is established. In such a case we may see errors establishing
>> flow control and they should be ignored.
>
> Indeed, before commit 19110cfbb34d ("e1000e: Separate signaling for link
> check/link up") a failure of e1000e_config_fc_after_link_up() in
> e1000e_check_for_copper_link() would be ignored. After that commit,
> there is an extra 2s delay before link up, like what was just fixed for
> autoneg in commit d8ca384786c2 ("e1000e: Fix check_for_link return value
> with autoneg off"). That was an unintended change in behavior. This is
> what this patch purports to fix. The same is true for other failure
> paths in e1000_check_for_copper_link_ich8lan() that happen after
> get_link_status = false.

Maybe we should just revert 19110cfbb34d ("e1000e: Separate signaling
for link check/link up"). Looking over the logic for it the whole
concept is just wrong. In the real-world it is actually possible for
us to lose link just after testing for it, and when that happens we
wouldn't want the link to be reported as up as it will appear to be a
link flap. If the LSC is actually firing that fast we would want to
stay down, and we know the original issue was we were getting false
LSC messages which should now be solved.

The reason why this behavior is the way it is was because the
assumption was that if we need to check for link then we should assume
the link is down. Getting false LSC events did cause link flaps, but
that was mostly due to misrecognized events, and now that we resolved
that it should no longer be the case. The fact that we are now
ignoring it after testing the link actually leads to undesirable
effects such as us having windows where the link is toggling up and
back down and we could possibly ignore it and report link up anyway
until we can get around to testing it again. If we make use of the RFC
you are currently working on to fix the race I pointed out, and we
revert the patch that separates signaling, then we should stay link
down during a LSC storm and come back up once the link has stabilized.
Otherwise we run the risk of reporting link up which may cause issues
if the link is electrically unstable after a cable is just connected
or pulled and we start trying to use it.

- Alex
