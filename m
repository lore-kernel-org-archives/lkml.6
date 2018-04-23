Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbeDWMx6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:53:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbeDWMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:53:57 -0400
Date: Mon, 23 Apr 2018 15:53:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180423125307.fpqn5shjq3rpsyx3@mwanda>
References: <20180419051510.GA21898@mwanda>
 <20180420124750.fgwrsyhuqd26mj34@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420124750.fgwrsyhuqd26mj34@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230133
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:47:51PM +0100, Mark Rutland wrote:
> > What the test does is it looks at array accesses where the user controls
> > the offset.  It asks "is this a read?" and have we used the
> > array_index_nospec() macro?  If the answers are yes, and no respectively
> > then print a warning.
> > 
> > http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c
> 
> I just built this and threw it at v4.17-rc1, but I'm having problems
> with the build_kernel_data.sh step.
> 
> I get an error:
> 
> DBD::SQLite::db do failed: unrecognized token: "'end + strlen("
> " at ../smatch/smatch_scripts/../smatch_data/db/fill_db_sql.pl line 32, <WARNS> line 294127.
> 
> ... in my smatch_warns.txt I see that I have the lines:
> 
> net/netfilter/nf_conntrack_sip.c:1524 sip_help_tcp() SQL: insert or ignore into constraints (str) values('end + strlen("^M
> ^M
> ")');
> 
> ... and the corresponding line in that file is:
> 
> for (; end + strlen("\r\n\r\n") <= dptr + datalen; end++) {
> 
> ... so I guess there's some dodgy escaping somewhere?
> 
> I only see a small number of potential spectre issues reported:

Yeah...  Sorry.  I will fix that.  It doesn't affect anything unless
someone starts to add SQL injection strings to the kernel but it's not
the right thing.

> 
> [mark@lakrids:~/src/linux]% grep 'potential spectre' smatch_warns.txt                                                                                
> block/scsi_ioctl.c:460 sg_scsi_ioctl() warn: potential spectre issue 'scsi_command_size_tbl'
> kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)
> kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)
> sound/core/pcm.c:140 snd_pcm_control_ioctl() warn: potential spectre issue 'pcm->streams' (local cap)
> net/compat.c:851 __do_compat_sys_socketcall() warn: potential spectre issue 'nas' (local cap)
> net/ipv6/syncookies.c:129 __cookie_v6_check() warn: potential spectre issue 'msstab'
> net/ipv6/udp.c:214 __udp6_lib_lookup() warn: potential spectre issue 'udptable->hash2'
> net/socket.c:2518 __do_sys_socketcall() warn: potential spectre issue 'nargs' (local cap)
> net/netfilter/nfnetlink.c:386 nfnetlink_rcv_batch() warn: potential spectre issue 'ss->cb'
> net/netfilter/nf_nat_sip.c:371 nf_nat_sip_expect() warn: potential spectre issue 'ct->tuplehash'
> net/core/net-procfs.c:262 ptype_seq_next() warn: potential spectre issue 'ptype_base'
> net/core/dev.c:392 ptype_head() warn: potential spectre issue 'ptype_base'
> net/ipv4/ipmr.c:1608 ipmr_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
> net/ipv4/ipmr.c:1682 ipmr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
> net/ipv4/syncookies.c:201 __cookie_v4_check() warn: potential spectre issue 'msstab'
> net/ipv4/udp.c:478 __udp4_lib_lookup() warn: potential spectre issue 'udptable->hash2'
> ipc/sem.c:2075 do_semtimedop() warn: potential spectre issue 'sma->sems'
> drivers/ata/libahci.c:1146 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)
> drivers/ptp/ptp_chardev.c:252 ptp_ioctl() warn: potential spectre issue 'ops->pin_config' (local cap)
> drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential spectre issue 'dma->buflist' (local cap)
> drivers/gpu/drm/i915/i915_query.c:115 i915_query_ioctl() warn: potential spectre issue 'i915_query_funcs'
> drivers/hid/usbhid/hiddev.c:473 hiddev_ioctl_usage() warn: potential spectre issue 'report->field' (local cap)
> drivers/hid/usbhid/hiddev.c:477 hiddev_ioctl_usage() warn: potential spectre issue 'field->usage' (local cap)
> drivers/hid/usbhid/hiddev.c:519 hiddev_ioctl_usage() warn: potential spectre issue 'field->value' (local cap)
> drivers/hid/usbhid/hiddev.c:757 hiddev_ioctl() warn: potential spectre issue 'report->field' (local cap)
> drivers/hid/usbhid/hiddev.c:801 hiddev_ioctl() warn: potential spectre issue 'hid->collection' (local cap)
> drivers/tty/vt/keyboard.c:1871 vt_do_kdsk_ioctl() warn: potential spectre issue 'key_map'
> drivers/tty/vt/vt_ioctl.c:711 vt_ioctl() warn: potential spectre issue 'vc_cons'
> 
> ... so I assume I've misunderstood how to use smatch. :)
> 

The thing is say we get user data in one function then pass it to the
next and the next down the call tree...  Smatch is only building one
layer of the call tree when you build the DB.  So you have to rebuild a
bunch of time (like 3 or maybe 5) each time you rebuild the DB.

Normally, I rebuild the DB every day so it just accretes.

regards,
dan carpenter
