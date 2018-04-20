Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbeDTMr4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:47:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48702 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:47:54 -0400
Date: Fri, 20 Apr 2018 13:47:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180420124750.fgwrsyhuqd26mj34@lakrids.cambridge.arm.com>
References: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419051510.GA21898@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Apr 19, 2018 at 08:15:10AM +0300, Dan Carpenter wrote:
> Several people have asked me to write this and I think one person was
> maybe working on writing it themselves...
> 
> The point of this check is to find place which might be vulnerable to
> the Spectre vulnerability.  In the kernel we have the array_index_nospec()
> macro which turns off speculation.  There are fewer than 10 places where
> it's used.  Meanwhile this check complains about 800 places where maybe
> it could be used.  Probably the 100x difference means there is something
> that I haven't understood...

At the time the array_index_nospec() mitigation was conceived, scanners
were in their infancy, and those of us looking at their findings simply
didn't have the bandwidth to check whether every finding was a viable
variant-1 gadget.

Those cases using array_index_nospec() are those which were deemed to be
an obviously viable gadget.

The hope was that we'd continue to look over those findings in the mean
time, and that scanners would improve to reduce false positives.

> What the test does is it looks at array accesses where the user controls
> the offset.  It asks "is this a read?" and have we used the
> array_index_nospec() macro?  If the answers are yes, and no respectively
> then print a warning.
> 
> http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c

I just built this and threw it at v4.17-rc1, but I'm having problems
with the build_kernel_data.sh step.

I get an error:

DBD::SQLite::db do failed: unrecognized token: "'end + strlen("
" at ../smatch/smatch_scripts/../smatch_data/db/fill_db_sql.pl line 32, <WARNS> line 294127.

... in my smatch_warns.txt I see that I have the lines:

net/netfilter/nf_conntrack_sip.c:1524 sip_help_tcp() SQL: insert or ignore into constraints (str) values('end + strlen("^M
^M
")');

... and the corresponding line in that file is:

for (; end + strlen("\r\n\r\n") <= dptr + datalen; end++) {

... so I guess there's some dodgy escaping somewhere?

I only see a small number of potential spectre issues reported:

[mark@lakrids:~/src/linux]% grep 'potential spectre' smatch_warns.txt                                                                                
block/scsi_ioctl.c:460 sg_scsi_ioctl() warn: potential spectre issue 'scsi_command_size_tbl'
kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)
kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)
sound/core/pcm.c:140 snd_pcm_control_ioctl() warn: potential spectre issue 'pcm->streams' (local cap)
net/compat.c:851 __do_compat_sys_socketcall() warn: potential spectre issue 'nas' (local cap)
net/ipv6/syncookies.c:129 __cookie_v6_check() warn: potential spectre issue 'msstab'
net/ipv6/udp.c:214 __udp6_lib_lookup() warn: potential spectre issue 'udptable->hash2'
net/socket.c:2518 __do_sys_socketcall() warn: potential spectre issue 'nargs' (local cap)
net/netfilter/nfnetlink.c:386 nfnetlink_rcv_batch() warn: potential spectre issue 'ss->cb'
net/netfilter/nf_nat_sip.c:371 nf_nat_sip_expect() warn: potential spectre issue 'ct->tuplehash'
net/core/net-procfs.c:262 ptype_seq_next() warn: potential spectre issue 'ptype_base'
net/core/dev.c:392 ptype_head() warn: potential spectre issue 'ptype_base'
net/ipv4/ipmr.c:1608 ipmr_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/ipv4/ipmr.c:1682 ipmr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/ipv4/syncookies.c:201 __cookie_v4_check() warn: potential spectre issue 'msstab'
net/ipv4/udp.c:478 __udp4_lib_lookup() warn: potential spectre issue 'udptable->hash2'
ipc/sem.c:2075 do_semtimedop() warn: potential spectre issue 'sma->sems'
drivers/ata/libahci.c:1146 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)
drivers/ptp/ptp_chardev.c:252 ptp_ioctl() warn: potential spectre issue 'ops->pin_config' (local cap)
drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential spectre issue 'dma->buflist' (local cap)
drivers/gpu/drm/i915/i915_query.c:115 i915_query_ioctl() warn: potential spectre issue 'i915_query_funcs'
drivers/hid/usbhid/hiddev.c:473 hiddev_ioctl_usage() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:477 hiddev_ioctl_usage() warn: potential spectre issue 'field->usage' (local cap)
drivers/hid/usbhid/hiddev.c:519 hiddev_ioctl_usage() warn: potential spectre issue 'field->value' (local cap)
drivers/hid/usbhid/hiddev.c:757 hiddev_ioctl() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:801 hiddev_ioctl() warn: potential spectre issue 'hid->collection' (local cap)
drivers/tty/vt/keyboard.c:1871 vt_do_kdsk_ioctl() warn: potential spectre issue 'key_map'
drivers/tty/vt/vt_ioctl.c:711 vt_ioctl() warn: potential spectre issue 'vc_cons'

... so I assume I've misunderstood how to use smatch. :)

> The other thing is that speculation probably goes to 200 instructions
> ahead at most.  But the Smatch doesn't have any concept of CPU
> instructions.  I've marked the offsets which were recently compared to
> something as "local cap" because they were probably compared to the
> array limit.  Those are maybe more likely to be under the 200 CPU
> instruction count.
> 
> This obviously a first draft.
> 
> What would help me, is maybe people could tell me why there are so many
> false positives.  Saying "the lower level checks for that" is not
> helpful but if you could tell me the exact function name where the check
> is that helps a lot...

I believe it is entirely possible that these are all viable gadgets
given a sufficiently long window for speculation.

Thanks,
Mark.
