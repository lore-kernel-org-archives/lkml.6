Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A6BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6642206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809346;
	bh=7m9I3WJsala1qCOaQlqkH+GibuF9QFKbu+rj5nuVyGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xDeYoKoznxBtj2PrK7x4z9HuyPWRKqbRAuAsgQdDxFxGOSULqQWCticdwKO7J0cKP
	 hSBVGrfrMak9tkqEWnZ0msehTTgYQzhkD97k14FvAG/kUAYV3XedbUeqvDMi6DyXML
	 tk27OppNmYxxAyXq2XqUZgWuR31DGMEeZc7gH16w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeLNRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeLNRmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB5320645;
        Fri, 14 Dec 2018 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809343;
        bh=7m9I3WJsala1qCOaQlqkH+GibuF9QFKbu+rj5nuVyGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9NJV2VAPXRUyvJB0aJrbZ1ThqJEbE+HlvIWPHxjkeBT/zqEroc8ECOqHmftnf/K9
         X+YnAW64PfARzdB9g6I4QE576aPJ8OMAD9qidN1SXe+rvSHKGM+2mjcrOwnlhrhtcs
         3cKBdDX05VjPSn1taawOYVdulLVMNxnb09/dUJs4=
Date:   Fri, 14 Dec 2018 18:42:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Michael J Gruber <mjg@fedoraproject.org>
Subject: Re: [PATCH 4.19 061/110] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181214174220.GA30170@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135923.722829835@linuxfoundation.org>
 <01000167adac3130-02698b6b-48d9-4496-9ce5-ee5316f5f82c-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000167adac3130-02698b6b-48d9-4496-9ce5-ee5316f5f82c-000000@email.amazonses.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 05:03:22PM +0000, Jeremy Cline wrote:
> Hi folks,
> 
> On 11/29/18 9:12 AM, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Erik Schmauss <erik.schmauss@intel.com>
> > 
> > commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> > 
> > The table load process omitted adding the operation region address
> > range to the global list. This omission is problematic because the OS
> > queries the global list to check for address range conflicts before
> > deciding which drivers to load. This commit may result in warning
> > messages that look like the following:
> > 
> > [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> > [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> > 
> > However, these messages do not signify regressions. It is a result of
> > properly adding address ranges within the global address list>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> > Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  drivers/acpi/acpica/dsopcode.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > --- a/drivers/acpi/acpica/dsopcode.c
> > +++ b/drivers/acpi/acpica/dsopcode.c
> > @@ -417,6 +417,10 @@ acpi_ds_eval_region_operands(struct acpi
> >  			  ACPI_FORMAT_UINT64(obj_desc->region.address),
> >  			  obj_desc->region.length));
> >  
> > +	status = acpi_ut_add_address_range(obj_desc->region.space_id,
> > +					   obj_desc->region.address,
> > +					   obj_desc->region.length, node);
> > +
> >  	/* Now the address and length are valid for this opregion */
> >  
> >  	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
> > 
> >
> Fedora has received a couple of reports[0] of boot failures on v4.19
> kernels:
> 
> kernel: BUG: unable to handle kernel paging request at 00000036000000b6
> kernel: PGD 0 P4D 0
> kernel: Oops: 0000 [#1] SMP NOPTI
> kernel: CPU: 0 PID: 108 Comm: kworker/0:3 Not tainted
> 4.19.8-300.fc29.x86_64 #1
> kernel: Hardware name: Hewlett-Packard HP Compaq 6715b/30C2, BIOS 68YTT
> Ver. F.07 07/16/2007
> kernel: Workqueue: events work_for_cpu_fn
> kernel: RIP: 0010:acpi_ns_build_normalized_path+0x76/0x108
> kernel: Code: 31 c0 48 85 ff 74 de 31 d2 49 89 f8 31 c0 4c 39 05 ff 5b
> 57 01 74 61 4c 39 c7 74 0e 39 c2 76 08 41 89 c1 42 c6 04 0e 2e ff c0
> <45> 8b 48 0c 41 89 ca 44 89 4c 24 04 45 31 c9 46 8a 5c 0c 07 45 84
> kernel: RSP: 0018:ffffb68740a1fce0 EFLAGS: 00010207
> kernel: RAX: 000000000000000a RBX: 0000000000000001 RCX: 0000000000000001
> kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9dd2360e7168
> kernel: RBP: 0000000000000000 R08: 00000036000000aa R09: fffffffffffffffc
> kernel: R10: 0000000000000000 R11: 00000000000000d2 R12: 0000000000008200
> kernel: R13: ffff9dd2360e7168 R14: ffff9dd2706980c0 R15: 0000000000000001
> kernel: FS:  0000000000000000(0000) GS:ffff9dd275c00000(0000)
> knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00000036000000b6 CR3: 000000007137e000 CR4: 00000000000006f0
> kernel: Call Trace:
> kernel:  acpi_ns_get_normalized_pathname+0x1f/0x6d
> kernel:  acpi_ut_check_address_range+0x8f/0x118
> kernel:  acpi_check_address_range+0x40/0x59
> kernel:  acpi_check_resource_conflict+0x3a/0x50
> kernel:  acpi_check_region+0x61/0x80
> kernel:  piix4_probe+0x144/0x658 [i2c_piix4]
> kernel:  local_pci_probe+0x41/0x90
> kernel:  work_for_cpu_fn+0x16/0x20
> kernel:  process_one_work+0x1a1/0x3a0
> kernel:  worker_thread+0x30/0x380
> kernel:  ? pwq_unbound_release_workfn+0xd0/0xd0
> kernel:  kthread+0x112/0x130
> kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
> kernel:  ret_from_fork+0x35/0x40
> kernel: Modules linked in: i2c_piix4(+) parport_pc wmi tpm_infineon
> parport ssb hp_accel lis3lv02d mmc_core input_polldev video radeon
> i2c_algo_bit drm_kms_helper ttm drm firewire_ohci firewire_core
> ata_generic serio_raw pata_acpi yenta_socket crc_itu_t pata_atiixp
> kernel: CR2: 00000036000000b6
> kernel: ---[ end trace 9c88eedaaeca7db0 ]---
> 
> I reverted this patch on v4.19.8 and at least one user (Michael, Cc'd)
> reported that fixed the regression.
> 
> This patch appears to have been included in v4.19.2 (commit
> 22083c028d0b), reverted in v4.19.3 (commit 8ef305fbc50d), and finally
> included again here in v4.19.6 (commit 87403e35bc56). I couldn't find
> a discussion about bringing it back, so maybe it happened accidentally?

No it was asked to be brought back, it was not an accident.

I think the acpi developers need to make up their mind :)

thanks,

greg k-h
