Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qgHvDy3kG1t6CwAAmS7hNA
	; Sat, 09 Jun 2018 14:29:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E36D4608BA; Sat,  9 Jun 2018 14:29:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xo9+Y0Va"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DRUGS_MUSCLE,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC348601C3;
	Sat,  9 Jun 2018 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC348601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeFIO2v (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeFIO2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:28:44 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D582087E;
        Sat,  9 Jun 2018 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528554523;
        bh=Ty7JYBjxv3jLGR0jlSEfudz9ocYOXfir5y5ihcntAZs=;
        h=Date:From:To:Cc:Subject:From;
        b=xo9+Y0VayxAG3eXgTXekUpZBUYx8I9rcZVIZRby4+o50u+2LZ9SSREQqnMM/x5kgr
         c4jfA/fFS91PMdGtaHx/UnGwb6iFNEspZ4FYs/sQ5HsMNJMN4Z8HSMXKPSqIHdJouX
         uepQRMwmpQqvGK0stw7CZJTaOUa7MTXoGl73khUU=
Date: Sat, 9 Jun 2018 16:28:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver patches for 4.18-rc1
Message-ID: <20180609142819.GA31307@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.18-rc1

for you to fetch changes up to 7a2e838d28cff6718a0bdf66164465402f8e40ed:

  staging: ipx: delete it from the tree (2018-06-05 19:23:26 +0200)

----------------------------------------------------------------
Staging/IIO patches for 4.18-rc1

Here is the big staging and IIO driver update for 4.18-rc1.

It was delayed as I wanted to make sure the final driver deletions did
not cause any major merge issues, and all now looks good.

There are a lot of patches here, just over 1000.  The diffstat summary
shows the major changes here:
	1007 files changed, 16828 insertions(+), 227770 deletions(-)
Because of this, we might be close to shrinking the overall kernel
source code size for two releases in a row.

There was loads of work in this release cycle, primarily:
	- tons of ks7010 driver cleanups
	- lots of mt7621 driver fixes and cleanups
	- most driver cleanups
	- wilc1000 fixes and cleanups
	- lots and lots of IIO driver cleanups and new additions
	- debugfs cleanups for all staging drivers
	- lots of other staging driver cleanups and fixes, the shortlog
	  has the full details.

but the big user-visable things here are the removal of 3 chunks of
code:
	- ncpfs and ipx were removed on schedule, no one has cared about
	  this code since it moved to staging last year, and if it needs
	  to come back, it can be reverted.
	- lustre file system is removed.  I've ranted at the lustre
	  developers about once a year for the past 5 years, with no
	  real forward progress at all to clean things up and get the
	  code into the "real" part of the kernel.  Given that the
	  lustre developers continue to work on an external tree and try
	  to port those changes to the in-kernel tree every once in a
	  while, this whole thing really really is not working out at
	  all.  So I'm deleting it so that the developers can spend the
	  time working in their out-of-tree location and get things
	  cleaned up properly to get merged into the tree correctly at a
	  later date.

Because of these file removals, you will have merge issues on some of
these files (2 in the ipx code, 1 in the ncpfs code, and 1 in the
atomisp driver).  Just delete those files, it's a simple merge :)

All of this has been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdun Nihaal (1):
      staging: most: video: remove debugging code

Adham Abozaeid (1):
      staging: wilc1000: Avoid overriding rates_no while parsing ies element.

Ajay Singh (106):
      staging: wilc1000: refactor scan() to free kmalloc memory on failure cases
      staging: wilc1000: removed unused static variables for gtk and ptk information
      staging: wilc1000: remove line over 80 char warnings in set_wiphy_params()
      staging: wilc1000: refactor WILC_WFI_p2p_rx() to avoid line over 80 char
      staging: wilc1000: rename WILC_WFI_p2p_rx & s32Freq to avoid camelCase
      staging: wilc1000: refactor mgmt_tx to fix line over 80 chars
      staging: wilc1000: rename hAgingTimer to avoid camelCase issue
      staging: wilc1000: fix line over 80 char issue in clear_shadow_scan()
      staging: wilc1000: remove line over 80 char in cfg_connect_result()
      staging: wilc1000: remove unused 'struct add_key_params'
      staging: wilc1000: remove line over 80 char warning in few functions
      staging: wilc1000: rename WILC_WFI_wep_key & WILC_WFI_wep_key_len
      staging: wilc1000: rename variable using datatype in their name in add_key()
      staging: wilc1000: split add_key() to avoid line over 80 chars
      staging: wilc1000: remove inner block {} and resetting of mode variable
      staging: wilc1000: refactor add_key() to avoid duplicated code
      staging: wilc1000: handle error condition in add_key() and remove auth_type variable
      staging: wilc1000: use sizeof(variable) for memory allocated to store key info
      staging: wilc1000: fix line over 80 chars in change_station()
      staging: wilc1000: rename WID_LOGTerminal_Switch to avoid camelCase
      staging: wilc1000: added identifiers name in function definations
      staging: wilc1000: remove unused macros in wilc module
      staging: wilc1000: remove multiple define used for MAX_SSID_LEN
      staging: wilc1000: remove multiple define for mac connect and disconnect
      staging: wilc1000: remove the use of goto label in spi_cmd_complete()
      staging: wilc1000: remove the use of goto label in wilc_spi_read_size()
      staging: wilc1000: remove the use of goto label in wilc_spi_read_int()
      staging: wilc1000: remove goto label '_done_' in handle_listen_state_expired()
      staging: wilc1000: remove the use of goto label in wilc_init()
      staging: wilc1000: rename goto label '_fail_' linux naming convension
      staging: wilc1000: rename goto labels starting with '_' in wilc1000_wlan_init()
      staging: wilc1000: remove the use of goto label in wilc_spi_clear_int_ext()
      staging: wilc1000: rename pu32InactiveTime to avoid camelCase issue
      staging: wilc1000: remove registering of ndo_do_ioctl callback
      staging: wilc1000: updated TODO list
      staging: wilc1000: align the #define in wilc_spi file
      staging: wilc1000: remove unnecessary assingment from 'if' conditions
      staging: wilc1000: remove 'cmd' variable in wilc_spi functions
      staging: wicl1000: removed the unsed variables in wilc_parse_network_info()
      staging: wilc1000: remove inner {} in wilc_parse_network_info()
      staging: wilc1000: simplified if conditions in spi_data_write()
      staging: wilc1000: remove unused variable scan_while_connected
      staging: wilc1000: remove unsed typedef wilc_debug_func
      staging: wilc1000: remove used #define HIF_SDIO_GPIO_IRQ
      staging: wilc1000: remove unused #define related to MAC status
      staging: wilc1000: rename mac status macros and moved related #define together
      staging: wilc1000: rename WILC_WFI_stats to avoid uppercase
      staging: wilc1000: rename num_reg_frame macro to have uppercase in macro name
      staging: wilc1000: rename wlan init and deinit function prefixed with wil1000
      staging: wilc1000: remove unused elements in 'wilc_priv' struct
      staging: wilc1000: remove unused enum 'stats_flags'
      staging: wilc1000: rename P2P_LISTEN_STATE variable to use lowercase
      staging: wilc1000: remove inner block '{}' in handle_remain_on_chan()
      staging: wilc1000: change function to static in linux_wlan
      staging: wilc1000: reorder functions to avoid forward declaration in linux_wlan
      staging: wilc1000: remove inner block in wilc_netdev_init()
      staging: wilc1000: remove unnecessary 'out of memory' message in handle_key()
      staging: wilc1000: modified NULL check used for 'if' condition in delete_key()
      staging: wilc1000: remove unnecessary bracket used in switch in wilc_mgmt_frame_register()
      staging: wilc1000: fix line over 80 chars in remove_network_from_shadow()
      staging: wilc1000: use 'else if' condition in get_station()
      staging: wilc1000: remove unnecessary file and function header comments
      staging: wilc1000: rename WILC_WFI_monitor_rx to avoid uppercase for function name
      staging: wilc1000: rename WILC_WFI_mon_priv to avoid uppercase for struct name
      staging: wilc1000: rename WILC_WFI_mon_xmit to avoid uppercase for function name
      staging: wilc1000: rename WILC_WFI_init_mon_interface to avoid uppercase in function name
      staging: wilc1000: rename WILC_WFI_deinit_mon_interface to avoid uppercase for function name
      staging: wilc1000: remove static variable 'del_beacon' and null check
      staging: wilc1000: remove the use of cur_byte variable in functions
      staging: wilc1000: remove unused macros in host_interface
      staging: wilc1000: remove unnecessary static function defination in wilc_spi
      staging: wilc1000: remove unnecessary header file inclusion for wilc
      staging: wilc1000: move macro after the #include file in wilc_wfi_netdevice
      staging: wilc1000: use is_broadcast_ether_addr check for broadcast address
      staging: wilc1000: rename 'during_ip_time' macro to have uppercase name for macro
      staging: wilc1000: rename WILC_WFI_band_2ghz variable to avoid mixedcase
      staging: wilc1000: added complete() call for error scenario in handle_key()
      staging: wilc1000: remove 'ret' variable in handle_key()
      staging: wilc1000: fix line over 80 chars in handle_key()
      staging: wilc1000: fix line over 80 characters issue in handle_connect()
      staging: wilc1000: fix line over 80 chars issue in host_int_handle_disconnect()
      staging: wilc1000: fix line over 80 characters in host_int_parse_join_bss_param()
      staging: wilc1000: fix line over 80 chars in host_int_parse_assoc_resp_info()
      staging: wilc1000: replace kmalloc with kmemdup() in handle_connect_timeout()
      staging: wilc1000: fix line over 80 chars in linux_mon
      staging: wilc1000: use sizeof(*wdev) to allocate memory in wilc_wfi_cfg_alloc()
      staging: wilc1000: use kmalloc(sizeof(*mgmt_tx)...) in mgmt_tx()
      staging: wilc1000: rename clear_duringIP() to avoid camelCase issue
      staging: wilc1000: fix line over 80 chars in add_network_to_shadow()
      staging: wilc1000: use kmemdup instead of kmalloc in add_network_to_shadow()
      staging: wilc1000: fix line over 80 charas in wilc_wfi_remain_on_channel_expired()
      staging: wilc1000: fix line over 80 chars in wilc_wfi_cfg_tx_vendor_spec()
      staging: wilc1000: fix line over 80 chars in get_station()
      staging: wilc1000: fix line over 80 chars in wilc_create_wiphy() declaration
      staging: wilc1000: fix line over 80 characters in add_key()
      staging: wilc1000: fix line over 80 chars in scan()
      staging: wilc1000: fix line over 80 chars issue in connect()
      staging: wilc1000: rename u8security to avoid datatype in variable name
      staging: wilc1000: refactor del_station() to avoid parenthesis misalignment
      staging: wilc1000: fix line over 80 chars in wilc_sdio struct
      staging: wilc1000: added #define for setting radiotap header
      staging: wilc1000: remove 'flag' argument from wilc_mac_indicate()
      staging: wilc1000: added comments for mutex and spinlock_t
      staging: wilc1000: remove unused 'lock' varible in 'wilc_priv' structure
      staging: wilc1000: remove s8idxarray to avoid datatype in variable name
      staging: wilc1000: refactor host_int_parse_assoc_resp_info() to remove unused code

Alexandru Ardelean (4):
      iio: adc: ad7791: remove sample freq sysfs attributes
      iio: adc: ad7791: implement IIO_CHAN_INFO_SAMP_FREQ
      iio: adc: ad7780: remove IIO_CHAN_INFO_SAMP_FREQ support
      iio: amplifiers: ad8366: move channel init before iio_device_register()

Alistair Strachan (3):
      staging: Android: vsoc: Create wc kernel mapping for region shm.
      staging: Android: vsoc: Fix a i386-randconfig warning.
      staging: Android: asoc: Fix sparse warnings in vsoc driver.

Andrew Perepechko (1):
      staging: lustre: mdc: excessive memory consumption by the xattr cache

Arnd Bergmann (2):
      staging: fsl-dpaa2/rtc: fix PTP dependency
      staging: lustre: include linux/highmem.h when needed

Arvind Yadav (1):
      staging: greybus: Use gpio_is_valid()

Bhanusree Pola (1):
      staging: comedi: comedi_usb.h: SPDX License Identifier is added in the first line

Bobi Jam (3):
      staging: lustre: llite: break up ll_setstripe_ea function
      staging: lustre: llite: return from ll_adjust_lum() if lump is NULL
      staging: lustre: llite: eat -EEXIST on setting trusted.lov

Brian Masney (41):
      staging: iio: tsl2x7x: remove unnecessary code
      staging: iio: tsl2x7x: correct interrupt handler trigger
      staging: iio: tsl2x7x: no need to clear interrupt flag when getting lux
      staging: iio: tsl2x7x: simplify tsl2x7x_prox_cal()
      staging: iio: tsl2x7x: split out als and prox interrupt settings
      staging: iio: tsl2x7x: make logging consistent and correct newlines
      staging: iio: tsl2x7x: split out als and prox persistence settings
      staging: iio: tsl2x7x: remove unused variables from tsl2x7x_get_lux()
      staging: iio: tsl2x7x: remove ch0 and ch1 variables from tsl2x7x_get_lux()
      staging: iio: tsl2x7x: put local variables in reverse Christmas tree order
      staging: iio: tsl2x7x: add copyright
      staging: iio: tsl2x7x: use auto increment I2C protocol
      staging: iio: tsl2x7x: use either direction for IIO_EV_INFO_{ENABLE,PERIOD}
      staging: iio: tsl2x7x: move integration_time* attributes to IIO_INTENSITY channel
      staging: iio: tsl2x7x: don't return error in IRQ handler
      staging: iio: tsl2x7x: simplify tsl2x7x_clear_interrupts function
      staging: iio: tsl2x7x: remove unnecessary chip status checks in suspend/resume
      staging: iio: tsl2x7x: simplify tsl2x7x_write_interrupt_config return
      staging: iio: tsl2x7x: simplify device id verification
      staging: iio: tsl2x7x: move power and diode settings into header file
      staging: iio: tsl2x7x: rename prx to prox for consistency
      staging: iio: tsl2x7x: use device defaults for als_time, prox_time and wait_time
      staging: iio: tsl2x7x: various comment cleanups
      staging: iio: tsl2x7x: rename prox_config to als_prox_config
      staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
      staging: iio: tsl2x7x: add range checking to three sysfs attributes
      staging: iio: tsl2x7x: don't setup event handlers if interrupts are not configured
      staging: iio: tsl2x7x: move calibscale_available attribute to IIO_INTENSITY channel
      staging: iio: tsl2x7x: use IIO_CONST_ATTR for calibscale_available
      staging: iio: tsl2x7x: correct integration time and lux equation
      staging: iio: tsl2x7x: add device ids for code readability
      staging: iio: tsl2x7x: remove unnecessary whitespace
      staging: iio: tsl2x7x: use direct returns
      staging: iio: tsl2x7x: turn chip off if IIO device registration fails
      staging: iio: tsl2x7x: use macro to populate tsl2X7X_device_info
      staging: iio: tsl2x7x: convert to use read_avail
      staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
      staging: iio: tsl2x7x: add range checking to tsl2x7x_write_raw
      staging: iio: tsl2x7x: rename driver to tsl2772
      staging: iio: tsl2x7x/tsl2772: move out of staging
      iio: tsl2583: correct values in integration_time_available

Charles Keepax (1):
      iio: accel: bcm150: Remove handling for regmap raw_read_max

Chris Coffey (1):
      staging: mt7621-eth: Fix sparse warning in ethtool.c

Christian Gromm (28):
      staging: most: allocate only all requested memory
      staging: most: dim2: remove clock speed processing from the HDM
      staging: most: i2c: prevent division by zero
      staging: most: i2c: remove unnecessary poison_channel call
      staging: most: add channel property dbr_size
      staging: most: aim-sound: add flexible format support
      staging: most: i2c: shorten lifetime of IRQ handler
      staging: most: i2c: do not wait in work function
      staging: most: i2c: avoid polling in case of misconfig
      staging: most: i2c: prevent zero delay polling
      staging: most: i2c: trace real polling rate
      staging: most: i2c: remove redundant is_open
      staging: most: i2c: remove redundant list_mutex
      staging: most: i2c: reduce parameters inconsistency
      staging: most: make interface drivers allocate coherent memory
      staging: most: sound: call snd_card_new with struct device
      staging: most: cdev: avoid warning about potentially uninitialized variable
      staging: most: cdev: fix chrdev_region leak
      staging: most: usb: add ep number to log
      staging: most: cdev: fix function return value
      staging: most: dim2: fix startup sequence
      staging: most: cdev: fix race condition
      staging: most: dim2: use device tree
      staging: most: dim2: read clock speed from the device
      staging: most: dim2: use device to allocate coherent memory
      staging: most: usb: don't set URB_ZERO_PACKET flag for synchronous data
      staging: most: usb: fix usb_disconnect race condition
      staging: most: usb: remove local variable

Christian Lütke-Stetzkamp (109):
      staging: mt7621-mmc: Remove whitespace errors in board.h
      staging: mt7621-mmc: Remove whitespace errors in dbg.c
      staging: mt7621-mmc: Remove whitespace errors in dbg.h
      staging: mt7621-mmc: Remove whitespace errors in mt6575_sd.h
      staging: mt7621-mmc: Remove whitespace errors in sd.c
      staging: mt7621-mmc: Fix indent for dbg.c
      staging: mt7621-mmc: Fix indent for board.h
      staging: mt7621-mmc: Fix indent for dbg.h
      staging: mt7621-mmc: Fix indent for mt6575_sd.h
      staging: mt7621-mmc: Fix indent for sd.c
      staging: mt7621-mmc: Fix spacing
      staging: mt7621-mmc: Fix Pointer Location
      staging: mt7621-mmc: Remove unnecessary typedefs
      staging: mt7621-mmc: Fix trailing statements
      staging: mt7621-mmc: Remove global initialise to 0
      staging: mt7621-mmc: Fix style of braces
      staging: mt7621-mmc: Remove redundant driver owner assignment
      staging: mt7621-mmc: Replace seq_printf with seq_puts where possible
      staging: mt7621-mmc: Remove code guarded by nonexistent config option
      staging: mt7621-mmc: Remove code for different soc types
      staging: mt7621-mmc: Remove unused datastructures
      staging: mt7621-mmc: Cleanup function mt_msdc_init
      staging: mt7621-mmc: Refactor suspend, resume
      staging: mt7621-mmc: Fix memory leek in case of error in probe
      staging: mt7621-mmc: Remove code checking for old kernel versions
      staging: mt7621-mmc: Fix unmatched release_mem_regin
      staging: mt7621-mmc: Fix bug on dma_alloc_coherent fail
      staging: mt7621-mmc: Remove unnecessary setting of dev.platform_data
      staging: mt7621-mmc: Remove unnecessary field from struct msdc_hw
      staging: mt7621-mmc: Fix different caps for different devices
      staging: mt7621-mmc: Remove dead codepath from probe function
      staging: mt7621-mmc: Fix dma_alloc_coherent should get device as first param
      staging: mt7621-mmc: Fix requesting of irq
      staging: mt7621-mmc: Remove duplicate defines
      staging: mt7621-mmc: Fix power management by removing old api
      staging: mt7621-mmc: Remove constant flag
      staging: mt7621-mmc: Remove unused global: msdc_6575_host
      staging: mt7621-mmc: Remove unused functions
      staging: mt7621-mmc: Remove constant flag MSDC_HIGHSPEED
      staging: mt7621-mmc: Remove error message in debug
      staging: mt7621-mmc: Fix debug file world writable
      staging: mt7621-mmc: Fix: copy_from_user() returns a positive value
      staging: mt7621-mmc: Remove redundant opcode check
      staging: mt7621-pci: Remove redundant owner assignment
      staging: mt7621-pinctrl: Remove redundant owner assignment
      staging: mt7621-spi: Remove redundant owner assignment
      staging: mt7621-mmc: Remove unused code from board.h
      staging: mt7621-mmc: Remove unused field get_cd_status from msdc_hw
      staging: mt7621-mmc: Remove unused field enable_cd_eirq from msdc_hw
      staging: mt7621-mmc: Remove unused field disable_cd_eirq
      staging: mt7621-mmc: Fix null pointer deref if ext sdio irq enabled
      staging: mt7621-mmc: Remove power callbacks from msdc_hw
      staging: mt7621-mmc: Refactor and rename msdc_reset to msdc_reset_hw
      staging: mt7621-mmc: Remove code for not existent config
      staging: mt7621-mmc: Relax cpu while waiting for stable clock
      staging: mt7621-mmc: Remove unused field data_offset from msdc_hw
      staging: mt7621-mmc: Remove unused field burstsz from msdc_dma
      staging: mt7621-mmc: Remove unused function msdc_dma_dump
      staging: mt7621-mmc: Start cleanup of msdc_dma_config
      staging: mt7621-mmc: Remove unused fields from msdc_dma
      staging: mt7621-mmc: Remove flags from msdc_dma
      staging: mt7621-mmc: Remove unused field xfersz from msdc_dma
      staging: mt7621-mmc: Refactor msdc_init_gpd_bd
      staging: mt7621-mmc: Change default transfer mode to DMA
      staging: mt7621-mmc: Remove unused field starttime from msdc_host
      staging: mt7621:mmc: Remove unused field reserved from msdc_host
      staging: mt7621-mmc: Remove unused field dma_left_size of msdc_host
      staging: mt7621-mmc: Remove unused field cmd_r1b_done in msdc_host
      staging: mt7621-mmc: Remove unused field cmd_rsp_done of msdc_host
      staging: mt7621-mmc: Remove unused field dma_addr of msdc_host
      staging: mt7621-mmc: Fix dereference before check in msdc_drv_pm
      staging: mt7621-mmc: Remove multiple assignments
      staging: mt7621-mmc: Fix dma_map_sg may map to fewer entries
      staging: mt7621-mmc: Replace dma dir with mmc_get_dma_dir
      staging: mt7621-mmc: Correct datatypes for io and sanitize io access
      staging: mt7621-mmc: Add annotations about held locks
      staging: mt7621-mmc: Remove old references to tasklet
      staging: mt7621-mmc: Remove unused card_workqueue from msdc_host
      staging: mt7621-mmc: Fix calculation typo in msdc_init_gpd_bd
      staging: mt7621-mmc: Fix typo in function parameters
      staging: mt7621-mmc: Remove unused field cmd_edge from msdc_hw
      staging: mt7621-mmc: Remove unused field data_edge from msdc_hw
      staging: mt7621-mmc: Remove unused field dat_drv from msdc_hw
      staging: mt7621-mmc: Remove unused field cmd_drv from msdc_hw
      staging: mt7621-mmc: Remove unused field clk_drv from msdc_hw
      staging: mt7621-mmc: Remove unused macro msdc_init_gpd_ex
      staging: mt7621-mmc: Remove unused macros sdr_{read,write}16
      staging: mt7621-mmc: Remove function uffs
      staging: mt7621-mmc: Replace macro sdr_set_field with function
      staging: mt7621-mmc: Replace macro sdr_get_field with function
      staging: mt7621-mmc: Remove unused static msdc_regs
      staging: mt7621-mmc: Remove transfer mode setting from proc
      staging: mt7621-mmc: Remove transfer mode setting variable
      staging: mt7621-mmc: Remove unused global dma_size
      staging: mt7621-mmc: Remove non-DMA transfer code
      staging: mt7621-mmc: Remove unused variable dma_xfer from msdc_host
      staging: mt7621-mmc: Fix error number assignment
      staging: mt7621-mmc: Remove unused field abort from msdc_host
      staging: mt7621-mmc: Remove unused sdio irq code
      staging: mt7621-mmc: Do not BUG() if mrq set in msdc_ops_request
      staging: mt7621-mmc: Remove redundant check for card status
      staging: mt7621-mmc: Remove initialisation in msdc_dma_config
      staging: mt7621-mmc: Inline function msdc_set_blknum
      staging: mt7621-mmc: Don't disables DMA
      staging: mt7621-mmc: Change return value of msdc_dma_config to void
      staging: mt7621-mmc: Always use linked DMA mode
      staging: mt7621-mmc: Remove unused macro HOST_MAX_NUM
      staging: mt7621-mmc: Cleanup includes
      staging: mt7621-mmc: Remove unused barrier macros

Christophe JAILLET (4):
      iio: sca3000: Fix an error handling path in 'sca3000_probe()'
      iio: sca3000: Handle errors returned by 'sca3000_configure_ring()' in 'sca3000_probe()'
      staging: lustre: Fix an error handling path in 'client_common_fill_super()'
      staging: lustre: Use 'kvfree()' for memory allocated by 'kvzalloc()'

Colin Ian King (10):
      staging: rtl8723bs: fix spelling mistakes: "dismatch" and "Inviation"
      staging: r8822be: fix typo in variable name "offest" -> "offset"
      staging: rtlwifi: fix spelling mistake: "traking" -> "tracking"
      staging: lustre: fix spelling mistake: "req_ulinked" -> "req_unlinked"
      staging: mt7621-mmc: fix spelling mistake: "Eanable" -> "Enable"
      iio: adc: fix spelling mistake: "Freeacale" -> "Freescale"
      staging: wilc1000: fix spelling mistake: "Preamle" -> "Preamble"
      staging: rtlwifi: fix spelling mistake: "Platfoem" -> "Platform"
      staging: greybus: fix spelling mistake: "Inavlid" -> "Invalid"
      staging: mt7621-mmc: fix spelling mistake: "Illgal" -> "Illegal"

Dan Carpenter (3):
      staging: kernel.h: Prevent macro expantion bug in container_of_safe()
      staging: fsl-mc/dpio: Fix the error handling in probe()
      staging: wilc1000: allocate less memory

Daniel Junho (1):
      staging: vboxvideo: Fix line size exceeding 80 columns.

Danilo Alves (1):
      staging: vt6655: remove unnecessary line breaks in function definition.

Dave Stevenson (10):
      staging: bcm2835-camera: Skip ISP pass to eliminate padding.
      staging: bcm2835-camera: Allocate context once per buffer
      staging: bcm2835-camera: Remove bulk_mutex as it is not required
      staging: bcm2835-camera: Match MMAL buffer count to V4L2.
      staging: bcm2835-camera: Remove V4L2/MMAL buffer remapping
      staging: bcm2835-camera: Add multiple include protection
      staging: bcm2835-camera: Move struct vchiq_mmal_rect
      staging: bcm2835-camera: Replace BUG_ON with return error
      staging: bcm2835-camera: Fix comment typos.
      staging: bcm2835-camera: Fix indentation of tables

David Veenstra (17):
      staging: iio: ad2s1200: Remove unneeded include
      staging: iio: ad2s1200: Sort includes alphabetically
      staging: iio: ad2s1200: Reverse Christmas tree ordering
      staging: iio: ad2s1200: Add blank lines
      staging: iio: ad2s1200: Improve readability with be16_to_cpup
      staging: iio: Documentation: Add missing sysfs docs for angle channel
      staging: iio: ad2s1200: Remove unneeded newline in license
      staging: iio: ad2s1200: Remove unneeded initializations
      staging: iio: ad2s1200: Add kernel docs to driver state
      staging: iio: ad2s1200: Setup spi before iio device register
      staging: iio: ad2s1200: Replace legacy gpio API with modern API
      staging: iio: ad2s1200: Replace platform data with dt bindings
      staging: iio: ad2s1200: Add dt table
      staging: iio: ad2s1200: Add scaling factor for angular velocity channel
      staging: iio: ad2s1200: Add scaling factor for angle channel
      staging: iio: ad2s1200: Add copyright
      staging: iio: ad2s1200: Move driver out of staging

Davide Spataro (1):
      staging: rtl8192e: rtllib_tx: fix spelling issue.

Dmitry Eremin (1):
      staging: lustre: llite: add support set_acl method in inode operations

Doug Oucahrek (1):
      staging: lustre: o2iblnd: fix race at kiblnd_connect_peer

Doug Oucharek (3):
      staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5
      staging: lustre: o2iblnd: Enable Multiple OPA Endpoints between Nodes
      staging: lustre: o2iblnd: Fix crash in kiblnd_handle_early_rxs()

Douglas Fischer (1):
      iio: imu: Add mpu9255 support to mpu6050 driver

Efstratios Gavas (1):
      staging: wlan-ng: prism2sta: fix indent coding-style issues

Eric Anholt (7):
      staging/vc04_services: Register a platform device for the camera driver.
      staging/bcm2835-camera: Set ourselves up as a platform driver.
      staging: bcm2835-camera: Fix warnings about string ops on v4l2 uapi.
      staging: bcm2835: Remove dead code related to framerate.
      staging: bcm2835: Fix mmal_port_parameter_get() signed/unsigned warnings.
      staging: bcm2835-camera: Fix module section mismatch warnings.
      staging: bcm2835-camera: Replace open-coded idr with a struct idr.

Eyal Ilsar (1):
      staging: wilc1000: Remove unnecessary braces {} around single statement block

Fabian Mewes (1):
      dt-bindings: iio: adc: mcp320x: Use vendor prefix compatible strings

Fabrice Gasnier (7):
      iio: adc: stm32-dfsdm: misc style improvements and fixes
      iio: adc: stm32-dfsdm: add check on max filter id
      iio: adc: stm32-dfsdm: add check on spi-max-frequency
      dt-bindings: iio: stm32-adc: add support for STM32MP1
      iio: adc: stm32-adc: add support for STM32MP1
      iio: adc: stm32-dfsdm: Add support for stm32mp1
      iio: adc: stm32-dfsdm: include stm32-dfsdm-adc.h

Fan Yong (1):
      staging: lustre: acl: increase ACL entries limitation

Gabriel Francisco Mandaji (1):
      staging: comedi: cb_pcidas64: fix alignment of function parameters

Gaurav Dhingra (1):
      staging: greybus: Fix warning to limit chars per line

Geert Uytterhoeven (3):
      staging: emxx_udc: Change platform dependency to ARCH_RENESAS
      staging: vc04_services: Remove depends on HAS_DMA in case of platform dependency
      dt-bindings: iio: afe: Spelling s/mesaurement/measurement/

Greg Hartman (1):
      staging: Android: Add 'vsoc' driver for cuttlefish.

Greg Kroah-Hartman (33):
      staging: gdm724x: add SPDX identifiers to all files.
      staging: gdm724x: remove redundant license information
      Merge 4.17-rc3 into staging-next
      Merge tag 'iio-for-4.18a' of git://git.kernel.org/.../jic23/iio into staging-next
      staging: most: video: fix build warnings
      Merge tag 'iio-for-4.18b' of git://git.kernel.org/.../jic23/iio into staging-next
      staging: lustre: fix build error in mdc_request.c
      staging: lustre: fix build error in errno.c
      staging: lustre: fix more build errors in errno.c
      staging: greybus: camera: no need to check debugfs return values
      staging: rtlwifi: don't check the return value of debugfs_create_file
      staging: unisys: visornic: no need to check debugfs return values
      staging: lustre: no need to check debugfs return values
      staging: lustre: remove ldebugfs_add_simple() wrapper
      staging: lustre: remove ldebugfs_register_stats() wrapper function
      staging: lustre: remove ldebugfs_seq_create() wrapper function
      staging: lustre: remove ldebugfs_obd_seq_create() wrapper function
      staging: lustre: unwrap some ldebugfs_register() calls
      staging: lustre: remove last two users of ldebugfs_register()
      staging: lustre: make ldebugfs_add_vars a void function
      staging: lustre: get rid of ldebugfs_remove()
      staging: vc04_services: no need to check debugfs return values
      staging: vc04_services: remove odd vchiq_debugfs_top() wrapper
      staging: vc04_services: move client dbg directory into static variable
      staging: vc04_services: remove struct vchiq_debugfs_info
      staging: vc04_services: vchiq_debugfs_log_entry can be a void *
      staging: vc04_services: no need to save the log debufs dentries
      staging: lustre: delete the filesystem from the tree.
      staging: ncpfs: delete it
      ncpfs: remove compat functionality
      ncpfs: remove Documentation
      ncpfs: remove uapi .h files
      staging: ipx: delete it from the tree

Gustavo A. R. Silva (2):
      staging: ks7010_sdio: fix NULL pointer dereference and memory leak
      staging: wilc1000: fix infinite loop and out-of-bounds access

Gwendal Grignou (1):
      iio: cros_ec: Move cros_ec_sensors_core.h in /include

Hans de Goede (1):
      iio: accel: st_accel: Add support for the SMO8840 ACPI id

Hernán Gonzalez (6):
      staging: iio: ad7746: Automatically swap values in readings/writings
      staging: iio: ad7746: Adjust arguments to match open parenthesis
      staging: iio: ad7746: Fix multiple line dereference
      staging: iio: ad7746: Reorder includes alphabetically
      staging: iio: ad7746: Reorder variable declarations
      staging: iio: ad7746: Fix bound checkings

Himanshu Jha (12):
      Staging: iio: accel: adis16201: Rename few macro definitions
      Staging: iio: accel: adis16201: Remove unnecessary comments
      Staging: iio: accel: adis16201: Add _REG suffix to registers
      Staging: iio: accel: adis16201: Group register definitions
      Staging: iio: accel: adis16201: Add comments about units in read_raw()
      Staging: iio: accel: adis16201: Use sign_extend32 function
      Staging: iio: accel: adis16201: Prefer reverse christmas tree ordering
      Staging: iio: accel: adis16201: Adjust argument to match open parentheses
      Staging: iio: accel: adis16201: Remove unused headers
      Staging: iio: accel: adis16201: Use GENMASK
      Staging: iio: accel: adis16201: Fix 80 character line limit
      Staging: iio: accel: adis16201: Move adis16201 driver out of staging

Hongchao Zhang (1):
      staging: lustre: obdclass: guarantee all keys filled

Ian Liu Rodrigues (1):
      Staging: most: Move comments to the end of line

Ioana Radulescu (1):
      staging: fsl-dpaa2/eth: Add support for hardware timestamping

Ivan Bornyakov (1):
      staging: lustre: libcfs: add parens around macros args

Ivan Safonov (1):
      staging:r8188eu: Remove rx_handler_data unnecessary read

James Simmons (10):
      staging: lustre: llite: initialize xattr->xe_namelen
      staging: lustre: llite: fix invalid size test in ll_setstripe_ea()
      staging: lustre: llite: remove newline in fullname strings
      staging: lustre: llite: record in stats attempted removal of lma/link xattr
      staging: lustre: llite: cleanup posix acl xattr code
      staging: lustre: llite: use proper types in the xattr code
      staging: lustre: llite: cleanup xattr code comments
      staging: lustre: llite: style changes in xattr.c
      staging: lustre: llite: correct removexattr detection
      staging: lustre: llite: create acl.c file

Janani Sankara Babu (1):
      Staging:rtl888eu:include Fix CamelCase issue

Jean-Baptiste Maneyrol (12):
      iio: imu: inv_mpu6050: clean double declaration of set_power_itg
      iio: imu: inv_mpu6050: do not flush fifo when iio buffer is full
      iio: imu: inv_mpu6050: clean set_power_itg and fix usage
      iio: imu: inv_mpu6050: use set_power_itg function in i2c mux
      iio: imu: inv_mpu6050: fix error path not turning chip back off
      iio: imu: inv_mpu6050: use devm_* at init and delete remove
      iio: imu: inv_mpu6050: clean read raw by factorizing out raw data
      iio: imu: inv_mpu6050: clean read channel data error path
      iio: imu: inv_mpu6050: use i2c mux only for chip with i2c aux bus
      iio: imu: inv_mpu6050: fix possible deadlock between mutex and iio
      iio: imu: inv_mpu6050: skip first sample when gyro is on
      iio: imu: inv_mpu6050: fix user_ctrl register overwritten

Ji-Hun Kim (3):
      staging: ks7010: replace kmalloc() + memcpy() with kmemdup()
      staging: vt6655: check for memory allocation failures
      staging: vt6655: add handling memory leak on vnt_start()

Jia-Ju Bai (7):
      staging: ks7010: Replace mdelay with usleep_range in ks7010_upload_firmware
      staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in ieee80211_ccmp_init
      staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in ieee80211_tkip_init
      staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in prism2_wep_init
      staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in ieee80211_softmac_init
      staging: rtl8192u: Replace mdelay with usleep_range in rtl8192_usb_disconnect
      staging: rtl8192u: Replace mdelay with usleep_range in dm_TXPowerTrackingCallback_TSSI

Joao Dalben (1):
      staging: rtl8192e: Fixed coding style around a plus sign

John L. Hammond (5):
      staging: lustre: libcfs: use dynamic minors for /dev/{lnet, obd}
      staging: lustre: llite: handle xattr cache refill race
      staging: lustre: llite: use xattr_handler name for ACLs
      staging: lustre: obdclass: hoist locking in lu_context_exit()
      staging: lustre: llite: remove unused parameters from md_{get, set}xattr()

John Syne (2):
      staging:iio:ade7854: Fix error handling on read/write
      staging:iio:ade7854: Fix the wrong number of bits to read

John Whitmore (5):
      staging: rtl8192e: Remove blank space before ', ' - coding style.
      staging: rtl8192e: Add blank space before '(' - coding style.
      staging: rtl8192e: Add spaces where required by coding standard
      staging: rtl8192e: correct position of '{', '}', '(' and ')' - coding style
      staging: rtl8192e: Correct indentation of switch statements - coding style

Jonathan Cameron (4):
      staging:iio:meter: Drop ADE7753 driver
      staging:iio:meter: Drop ADE7754 driver
      staging:iio:meter: Drop ADE7758 driver
      staging:iio:meter: Drop ADE7759 driver

Justin Skists (1):
      staging: lustre: lnet: add static to libcfs_dev declaration

Kamal Heib (9):
      staging: mt7621-eth: Fix compilation error
      staging: mt7621-eth: Remove unnecessary blank lines
      staging: mt7621-eth: Add missing blank lines after declarations
      staging: mt7621-eth: Alignment should match open parenthesis
      staging: mt7621-eth: Prefer unsigned int to bare use of unsigned
      staging: mt7621-eth: Fix line over 80 characters
      staging: mt7621-eth: Fix quoted string split across lines
      staging: mt7621-eth: Refactor ethtool stats
      staging: mt7621-eth: Remove unused variable

Kilian Köppchen (1):
      staging: bcm2835: Use BIT_ULL macro

Kirill Marinushkin (1):
      staging: bcm2835-audio: Disconnect and free vchi_instance on module_exit()

Lai Siyao (1):
      staging: lustre: obdclass: change object lookup to no wait mode

Laura Abbott (1):
      staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy

Li Xi (1):
      staging: lustre: obdclass: change spinlock of key to rwlock

Linus Walleij (9):
      staging: emxx_udc: Add GPIO descriptor work to TODO
      staging: fbtft: Add TODO file with GPIO work item
      staging: greybus: Add TODO file with GPIO work items
      staging: iio: Augment TODO file with GPIO work item
      staging: atomisp: Augment TODO file with GPIO work item
      staging: gpio-mt7621: Include the right header
      staging: nvec: Augment TODO file with GPIO work item
      staging: olpc_dcon: Augment TODO file with GPIO work item
      staging: wilc1000: Augment TODO file with GPIO work item

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix FIFO threshold mask for LSM6DSM/LSM6DSL
      iio: imu: st_lsm6dsx: add support to ism330dlc
      Documentation: dt: iio: imu: st_lsm6dsx: add ism330dlc sensor device binding

Luc Van Oostenryck (6):
      staging/wilc1000: fix wilc_mac_xmit()'s return type
      staging: wlan-ng: fix p80211knetdev_hard_start_xmit()'s return type
      staging: visornic: fix visornic_xmit()'s return type
      staging: rtl8723bs: fix rtw_cfg80211_monitor_if_xmit_entry()'s return type
      staging: gdm724x: fix gdm_lte_tx()'s return type
      staging: vboxvideo: fix mode_valid's return type

Marc Dietrich (3):
      staging: nvec: cleanup use of dev in probe function
      staging: nvec: convert to use GPIO descriptors
      Revert "staging: nvec: Augment TODO file with GPIO work item"

Martin Kelly (7):
      iio:imu: inv_mpu6050: support more interrupt types
      dt-bindings: iio:imu:mpu6050: support more interrupt types
      iio: imu: inv_mpu6050: minor wording fixes
      iio: imu: inv_mpu6050: make loop a do-while
      tools: iio: iio_generic_buffer: fix types to match
      tools: iio: iio_generic_buffer: allow continuous looping
      iio: imu: inv_mpu6050: add comment about frequencies

Matt Ranostay (2):
      iio: chemical: atlas-ph-sensor: use msleep() for long uncritical delays
      iio: potentiostat: lmp91000: add LMP91002 support

Mauro Carvalho Chehab (1):
      iio: iio.h: use nested struct support on kernel-doc markup

Nathan Chancellor (18):
      staging: rtlwifi: Replace license boilerplate with SPDX identifiers
      staging: wilc1000: Remove unused variables
      staging: wilc1000: Remove useless function
      staging: wilc1000: Remove unnecessary array index check
      staging: board: Replace license boilerplate with SPDX identifiers
      staging: greybus: Remove unused local variable
      staging: android: Kconfig; Remove excessive hyphens
      staging: android: Clean up license identifiers
      staging: android: vsoc: Fix ending '(' warnings in function defintions
      staging: android: vsoc: Fix ending '(' warnings in do_destroy_fd_scoped_permission
      staging: android: vsoc: Fix ending '(' warnings in vsoc_ioctl
      staging: android: vsoc: Fix ending '(' warnings in vsoc_probe_device
      staging: android: ion: Fix license identifier comment format
      staging: android: ion: Remove unnecessary blank line
      staging: ks7010: Remove unnecessary limit checks
      staging: rtl8723bs: Replace license boilerplate with SPDX identifiers
      staging: android: ion: Check return value of ion_buffer_kmap_get
      staging: ks7010: Remove unused define

NeilBrown (73):
      staging: lustre: remove invariant in cl_io_read_ahead()
      staging: lustre: remove unused ldlm_completion_ast_async()
      staging: lustre: remove unused hash tables.
      staging: lustre: remove unneeded include.
      staging: lustre: tidy up ldlm_resource_putref()
      staging: lustre: ldlm: free resource when ldlm_lock_create() fails.
      staging: lustre: cfs_time_current() -> jiffies.
      staging: lustre: libcfs: discard cfs_time_add/sub
      staging: lustre: libcfs: discard cfs_time_shift().
      staging: lustre: libcfs: discard cfs_time_after()
      staging: lustre: libcfs: remove cfs_timeout_cap()
      staging: lustre: discard cfs_duration_sec()
      staging: lustre: discard cfs_time_before_64()
      staging: lustre: discard linux-time.h
      staging: lustre: remove cruft from libcfs/linux/libcfs.h
      staging: lustre: move stack-check macros to libcfs_debug.h
      staging: lustre: remove libcfs/linux/libcfs.h
      staging: lustre: ptlrpc: convert conn_hash to rhashtable
      staging: lustre: convert lov_pool to use rhashtable
      staging: lustre: convert obd uuid hash to rhashtable
      staging: lustre: convert osc_quota hash to rhashtable
      staging: lustre: remove include/linux/libcfs/linux/linux-cpu.h
      staging: lustre: rearrange placement of CPU partition management code.
      staging: lustre: add container_of_safe()
      staging: mt7621-pci: Hack 2 more PCI interrupts for gnubee1
      staging: lustre: ldlm: store name directly in namespace.
      staging: mt7621-eth: Lock is never unlocked.
      staging: mt7621-spi: remove unused lock.
      staging: mt7621-pci: improve interrupt mapping
      staging: mt7621-pci: white-space cleanups.
      staging: mt7621-pci: remove conditional compilation.
      staging: mt7621-pci: remove unnecessary resource details.
      staging: mt7621-pci: remove some dead code.
      staging: mt7621-dts: update nor-flash info for gnubee1
      staging: lustre: make struct lu_site_bkt_data private
      staging: lustre: lu_object: discard extra lru count.
      staging: lustre: lu_object: move retry logic inside htable_lookup
      staging: lustre: fold lu_object_new() into lu_object_find_at()
      staging: lustre: llite: use more private data in dump_pgcache
      staging: lustre: llite: remove redundant lookup in dump_pgcache
      staging: lustre: move misc-device registration closer to related code.
      staging: lustre: move remaining code from linux-module.c to module.c
      staging: lustre: fix error deref in ll_splice_alias().
      staging: lustre: osc: tidy up osc_init()
      staging: lustre: refactor libcfs initialization.
      staging: lustre: move files out of lustre/lnet/libcfs/linux/
      staging: lustre: rename cfs_cpt_table to cfs_cpt_tab
      staging: lustre: remove conditional compilation from libcfs_cpu.c
      staging: lustre: remove current_pid() and current_comm()
      staging: lustre: simplify capability dropping.
      staging: lustre: discard cfs_cap_t, use kernel_cap_t
      staging: lustre: discard LOWEST_BIT_SET()
      staging: lustre: discard CFS_TICK
      staging: lustre: move LERRCHKSUM() to libcfs_debug.h
      staging: lustre: discard cfs_block_sigsinv()
      staging: lustre: replace libcfs_register_ioctl with a blocking notifier_chain
      staging: lustre: clean up __LIBCFS_H macro
      staging: lustre: make lnet_debugfs_symlink_def local to libcfs/modules.c
      staging: lustre: move lnet_debug_log_upcall declaration to tracefile.h
      staging: lustre: move RESV_PORT definitions to lnet/lib-lnet.h
      staging: lustre: replace memory_presure funcitons by standard interfaces.
      staging: lustre: discard libcfs_prim.h
      staging: lustre: start moving includes out of libcfs.h
      staging: lustre: don't include libcfs.h in lnet/lib-lnet.h
      staging: lustre: remove libcfs_all.h includes from lnet/klnd
      staging: lustre: remove libcfs_all.h from includes lustre/lnet
      staging: lustre: remove libcfs_all.h from lustre/include/*.h
      staging: lustre: remove libcfs_all.h from remaining .h files.
      staging: lustre: remove libcfs_all from ptlrpc
      staging: lustre: remove libcfs_all.h from fid, fld, obdclass
      staging: lustre: remove remaining libcfs_all.h includes from lustre/lustre
      staging: lustre: move all libcfs_all includes except in lustre/lnet/libcfs/
      staging: lustre: remove libcfs_all.h

Nguyen Phan Quang Minh (1):
      staging: fsl-dpaa2/ethsw: Remove unused variable irq

Nishad Kamdar (1):
      staging: comedi: comedidev.h: Fix SPDX-License-Identifier tag style

Niu Yawei (2):
      staging: lustre: llite: refactor lustre.lov xattr handling
      staging: lustre: llite: add simple comment about lustre.lov xattrs

Peter Rosin (6):
      iio: potentiometer: mcp4018: switch to using .probe_new
      iio: potentiometer: mcp4531: switch to using .probe_new
      dt-bindings: iio: afe: add binding for current-sense-shunt
      dt-bindings: iio: afe: add binding for voltage-divider
      dt-bindings: iio: afe: add binding for current-sense-amplifier
      iio: afe: rescale: new driver

Pratik Jain (1):
      Staging:Comedi:comedi_compat32.c: Lindent changes

Quytelda Kahja (75):
      staging: ks7010: Use the ARRAY_SIZE() macro to calculate array sizes.
      staging: ks7010: Remove trailing _t from 'struct wpa_suite_t'.
      staging: ks7010: Remove trailing _t from 'struct rsn_mode_t'.
      staging: ks7010: Remove trailing _t from 'struct pmk_cache_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_data_request_t'.
      staging: ks7010: Remove unused 'struct hostif_data_indication_t'.
      staging: ks7010: Remove trailing _t from 'struct channel_list_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_mib_get_request_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_mib_value_t'.
      staging: ks7010: Remove unused 'struct hostif_mib_set_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_power_mgmt_request_t'.
      staging: ks7010: Remove unused 'struct hostif_power_mgmt_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_start_request_t'.
      staging: ks7010: Remove unused 'struct hostif_start_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct ssid_t'.
      staging: ks7010: Remove trailing _t from 'struct rate_set8_t'.
      staging: ks7010: Remove trailing _t from 'struct fh_parms_t'.
      staging: ks7010: Remove trailing _t from 'struct ds_parms_t'.
      staging: ks7010: Remove trailing _t from 'struct cf_parms_t'.
      staging: ks7010: Remove trailing _t from 'struct ibss_parms_t'.
      staging: ks7010: Remove trailing _t from 'struct rate_set16_t'.
      staging: ks7010: Remove trailing _t from 'struct ap_info_t'.
      staging: ks7010: Remove trailing _t from 'struct link_ap_info_t'.
      staging: ks7010: Remove unused 'struct hostif_connect_indication_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_stop_request_t'.
      staging: ks7010: Remove unused 'struct hostif_stop_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_request_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_ps_adhoc_set_request_t'.
      staging: ks7010: Remove unused 'struct hostif_ps_adhoc_set_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_infrastructure_set_request_t'.
      staging: ks7010: Remove unused 'struct hostif_infrastructure_set_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set_request_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set2_request_t'.
      staging: ks7010: Remove unused 'struct hostif_adhoc_set_confirm_t'.
      staging: ks7010: Remove unused 'struct last_associate_t'.
      staging: ks7010: Remove trailing _t from 'struct association_request_t'.
      staging: ks7010: Remove trailing _t from 'struct association_response_t'.
      staging: ks7010: Remove unused 'struct hostif_associate_indication_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_bss_scan_request_t'.
      staging: ks7010: Remove unused 'struct hostif_bss_scan_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_phy_information_request_t'.
      staging: ks7010: Remove unused 'struct hostif_phy_information_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_sleep_request_t'.
      staging: ks7010: Remove unused 'struct hostif_sleep_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostif_mic_failure_request_t'.
      staging: ks7010: Remove unused 'struct hostif_mic_failure_confirm_t'.
      staging: ks7010: Remove trailing _t from 'struct hostt_t'.
      staging: ks7010: Remove trailing _t from 'struct rsn_ie_t'.
      staging: ks7010: Remove trailing _t from 'struct wps_ie_t'.
      staging: ks7010: Remove trailing _t from 'struct local_ap_t'.
      staging: ks7010: Remove trailing _t from 'struct local_aplist_t'.
      staging: ks7010: Remove trailing _t from 'struct local_gain_t'.
      staging: ks7010: Remove trailing _t from 'struct local_eeprom_sum_t'.
      staging: ks7010: Remove trailing _t from 'struct power_save_status_t'.
      staging: ks7010: Remove trailing _t from 'struct sleep_status_t'.
      staging: ks7010: Remove trailing _t from 'struct scan_ext_t'.
      staging: ks7010: Remove trailing _t from 'struct wpa_key_t'.
      staging: ks7010: Remove trailing _t from 'struct mic_failure_t'.
      staging: ks7010: Remove trailing _t from 'struct wpa_status_t'.
      staging: ks7010: Remove trailing _t from 'struct pmk_list_t'.
      staging: ks7010: Remove trailing _t from 'struct pmk_t'.
      staging: ks7010: Remove trailing _t from 'struct wps_status_t'.
      staging: ks7010: Remove trailing _t from 'struct michael_mic_t'.
      staging: ks7010: Rename ks_wlan_set_multicast_list()
      staging: ks7010: Change 'device_open_status' to a bool.
      staging: ks7010: Remove unnecessary casts in 'struct ks_wlan_handler_def'.
      staging: rtl8723bs: Rename 'Hal8723BPwrSeq.{c, h}' to 'hal_pwr_seq.*'.
      staging: rtl8723bs: Rename 'Hal8723bPhyReg.h' using snake case.
      staging: rtl8723bs: Rename 'Hal8723BPhyCfg.h' using snake case.
      staging: rtl8723bs: Clean up whitespace in 'rtl8723_hal.h'.
      staging: rtl8723bs: Fix camel-case in IS_FW_HEADER_EXIST_8723B().
      staging: rtl8723bs: Fix camel-case in 'struct rt_firmware'.
      staging: rtl8723bs: Fix spelling/grammar errors in comment.
      staging: rtl8723bs: Fix camel-case in 'struct rt_firmware_hdr'.
      staging: rtl8723bs: Fix grammar error in comment.

Razvan Stefanescu (1):
      staging: fsl-dpaa2/ethsw: Fix tag control information value overwrite

Renato Soma (1):
      staging: fbtft: Fixed lines exceeding columns limit

Richard Tresidder (2):
      iio: magnetometer: mag3110: Add ability to run in continuous mode
      iio: accell: mma8452: Reduce sleep time when data not ready

Robin Humble (1):
      staging: lustre: llite: Remove filtering of seclabel xattr

Rodrigo Siqueira (6):
      staging:iio:ade7854: Rework I2C write function
      staging:iio:ade7854: Rework SPI write function
      staging:iio:ade7854: Remove write_reg_* duplications
      staging:iio:ade7854: Rework I2C read function
      staging:iio:ade7854: Rework SPI read function
      staging:iio:ade7854: Remove read_reg_* duplications

Roman Kiryanov (1):
      Delete the goldfish_nand driver.

Roy Pledge (2):
      drivers/staging/fsl-mc: Use devm_memremap/devm_ioremap for DPIO
      drivers/staging/fsl-mc: Fix DPIO error path issue

Sabin Mihai Rapan (4):
      staging: lustre: Fix "from from"->"from"
      staging: lustre: Fix "Possible intergrate"->"Possibly integrate"
      staging: lustre: Fix "unsigned"->"unsigned int"
      staging: lustre: Fix block comments style

Samuel Thibault (3):
      staging: speakup: Add pause command used on switching to graphical mode
      staging: speakup: Fix coding style
      staging: speakup: use true/false instead of 1/0

Sankalp Negi (2):
      staging: mt7621-pci: Fix line size exceeding 80 columns.
      staging: mt7621-mmc: Fix line size exceeding 80 columns

Sean Nyekjaer (3):
      iio: dac: add TI DAC5571 family support
      iio: ti-dac5571: Add DT binding documentation
      iio: adc: ti-ads8688: add trigger and buffer support

Sergio Paracuellos (203):
      staging: ks7010: replace IS_11B_RATE macro with inline function
      staging: ks7010: replace IS_OFDM_RATE macro with inline function
      staging: ks7010: replace IS_11BG_RATE macro with inline function
      staging: ks7010: IS_OFDM_EXT_RATE macro with inline function
      staging: ks7010: replace IS_HIF_IND with inline function
      staging: ks7010: replace IS_HIF_CONF with inline function
      staging: ks7010: remove unnecessary 'out of memory' message
      staging: ks7010: factor out irq enable process to ks7010_sdio_init_irqs
      staging: ks7010: fix label to jump to in error case
      staging: ks7010: factor out irq setup process to ks7010_sdio_setup_irqs
      staging: ks7010: factor out ks_wlan_private init process into ks7010_private_init
      staging: ks7010: factor out initial enqueue process into ks7010_sme_enqueue_events
      staging: ks7010: fix error handling in ks7010_upload_firmware
      staging: ks7010: ks7010: factor out firmware copy process into ks7010_copy_firmware
      staging: ks7010: fix some style issues about long lines
      staging: ks7010: remove not used enum values from eap_packet.h header
      staging: ks7010: remove EAPOL_VERSION preprocessor definition
      staging: ks7010: remove two redefined defines in eap_packet.h header
      staging: ks7010: change ETHER_HDR_SIZE definition to use the size of struct ether_hdr
      staging: ks7010: indent enum properly in eap_packet.h header file
      staging: ks7010: move and rename DEVICE_ALIGNMENT into correct header
      staging: ks7010: remove KS_ATOM preprocessor condtional code
      staging: ks7010: rewrite hif_align_size inline function
      staging: ks7010: remove KS_WLAN_MEM_FLAG definition
      staging: ks7010: remove nosense #if 1 directive
      staging: ks7010: remove '\' character from michael_block function
      staging: ks7010: remove nonsense comment
      staging: ks7010: fix remaining long line warnings in ks7010_sdio source
      staging: ks7010: change sdio related read/write function parameter types
      staging: ks7010: use msecs_to_jiffies in ks7010_rw_function function
      staging: ks7010: use linux circular buffer header macros to handle tx and rx queues
      staging: ks7010: change return value of ks_wlan_do_power_save function
      staging: ks7010: remove nonsense break from case block
      staging: ks7010: refactor code for hostif_sme_sleep_set function
      staging: ks7010: group some cases in switch-case block in hostif_mib_set_confirm
      staging: ks7010: remove struct ieee802_1x_eapol_key
      staging: ks7010: remove not used enum in eap_packet header file
      staging: ks7010: remove auxiliar zeros buffer in ks_wlan_get_encode
      staging: ks7010: refactor ks_wlan_set_encode function
      staging: ks7010: change if-else condition assignment to use ternary operator
      staging: ks7010: refactor ks_wlan_set_rx_gain function
      staging: ks7010: refactor ks_wlan_set_tx_gain function
      staging: ks7010: refactor ks_wlan_set_wps_enable function
      staging: ks7010: review includes of ks_wlan_net.c file
      staging: ks7010: review includes of ks_wlan.h file
      staging: ks7010: remove enum from ks_wlan.h header
      staging: ks7010: review includes of ks7010_sdio file
      staging: ks7010: review includes of michael_mic.c file
      staging: ks7010: align comments in ks_wlan_private_handler
      staging: ks7010: init local variables when they are declared in ks7010_sdio_probe
      staging: mt7621-gpio: prefer unsigned int to bare unsigned
      staging: ks7010: avoid casts in michael_mic_function calls
      staging: ks7010: move ROM_FILE definition into source file
      staging: ks7010: move sdio specific register definitions into source file
      staging: ks7010: delete not used definitions in ks7010_sdio source
      staging: ks7010: add REG suffix to sdio register definitions
      staging: ks7010: review comment style in ks7010_sdio source file
      staging: ks7010: review debug and error messages in ks7010_sdio source
      staging: ks7010: avoid one extra level indentation in ks_wlan_hw_rx function
      staging: ks7010: move MODULE_DEVICE_TABLE related code
      staging: ks7010: replace create_workqueue with alloc_workqueue
      staging: ks7010: check sdio_set_block_size return value
      staging: ks7010: fix error paths in ks7010_sdio_remove function
      staging: ks7010: use u8 instead of unsigned char for firmware buffers
      staging: ks7010: assign dev_alloc_name() result to variable before check it
      staging: ks7010: change name and type for device_open_status field
      staging: ks7010: avoid one level indentation in devio_rec_ind function
      staging: ks7010: remove superfluous comments in ks_hostif source file
      staging: ks7010: fix warning aout long line in init_request
      staging: ks7010: avoid blank line between definitions in hostif_data_request
      staging: ks7010: remove two fields of ks_wlan_private struct
      staging: ks7010: removes data_buff field of ks_wlan_private struct
      staging: ks7010: review includes of ks_hostif file
      staging: ks7010: use IW_HANDLER macro in ks_wlan_handler
      staging: ks7010: remove KSC_OPNOTSUPP related code
      staging: ks7010: avoid some if-else code in get_current_ap function
      staging: ks7010: join some debug traces in get_current_ap function
      staging: ks7010: use definitions from kernel headers in hostif_data_indication function
      staging: ks7010: refactor hostif_sme_power_mgmt_set function
      staging: ks7010: avoid use of brackets in single line if
      staging: ks7010: remove some duplicated definitions in ks_wlan_net.c
      staging: ks7010: refactor ks_wlan_set_mode function
      staging: ks7010: refactor ks_wlan_get_mode function
      staging: ks7010: fix line exceding 80 characters in ks_wlan_get_range
      staging: ks7010: remove WPS definition conditional code
      staging: ks7010: remove duplicated ks_wlan_handler_def declaration
      staging: ks7010: use ether_addr_copy() instead of custom copy
      staging: ks7010: use ether_addr_copy in hostif_mib_get_confirm
      staging: ks7010: use ether_addr_equal in hostif_data_indication
      staging: ks7010: use ether_addr_equal in hostif_data_request
      staging: ks7010: use ether_addr_copy in hostif_sme_multicast_set
      staging: ks7010: refactor hostif_sme_set_pmksa function
      staging: ks7010: refactor ks_wlan_set_beacon_lost function
      staging: ks7010: refactor ks_wlan_set_scan_type function
      staging: ks7010: refactor ks_wlan_set_power_mgmt function
      staging: ks7010: refactor ks_wlan_set_preamble function
      staging: ks7010: refactor ks_wlan_set_cts_mode function
      staging: ks7010: refactor ks_wlan_set_pmksa function
      staging: ks7010: use ether_addr_copy in ks_wlan_set_encode_ext
      staging: ks7010: align values in frequency_list array
      staging: ks7010: refactor ks_wlan_set_wap function
      staging: ks7010: use ether_addr_copy in ks_wlan_get_wap
      staging: ks7010: avoid an 'else' in ks_wlan_set_power
      staging: ks7010: avoid if-else condition in ks_wlan_get_power
      staging: ks7010: use ether_addr_copy in ks_wlan_get_aplist
      staging: ks7010: avoid blank line between declarations in ks_wlan_get_aplist
      staging: ks7010: refactor ks_wlan_translate_scan function
      staging: ks7010: add SPDX identifiers to all files
      staging: ks7010: move tx and rx queues definitions into ks_wlan.h header
      staging: ks7010: avoid ks_sdio_card dependency in ks_wlan header
      staging: ks7010: change netdev_dbg msg to avoid a long line
      staging: ks7010: remove missing WPS preprocessor conditional code
      staging: ks7010: use u8 instead of unsigned char in write_to_device function
      staging: ks7010: change local variable type in _ks_wlan_hw_power_save
      staging: ks7010: change local variable type in ks7010_rw_function
      staging: ks7010: change some local variables type in ks_sdio_interrupt
      staging: ks7010: change local variable type in ks7010_sdio_init_irqs
      staging: ks7010: use the same parameter for 'event' in hostif_sme_enqueue
      staging: ks7010: refactor ks7010_sme_enqueue_events function
      staging: ks7010: change local variable type in ks_wlan_hw_rx
      staging: ks7010: remove nonsense comment in ks_wlan.h file
      staging: ks7010: clean SME_MIC_FAILURE_REQUEST case in hostif_sme_execute
      staging: ks7010: convert MIB preprocessor defs into an enum
      staging: ks7010: conver MIB attributes preprocessor defs into an enum
      staging: ks7010: change some casts from uint8_t to u8 in ks_hostif header
      staging: ks7010: change parameter types and reorder them in hostif_mib_set_request
      staging: ks7010: add new helpers to achieve mib set request and simplify code
      staging: ks7010: use ether_addr_copy in get_current_ap
      staging: ks7010: move two preprocessor definitions to ks_wlan.h
      staging: ks7010: avoid two long lines in hostif_sme_mode_setup
      staging: ks7010: remove non sense comments in ks_hostif.c source file
      staging: ks7010: change type for rsn_enabled in wpa_status struct
      staging: ks7010: use ether_addr_copy to copy ethernet address sa_data
      staging: ks7010: use ether_addr_copy in get_ap_information function
      staging: ks7010: move WLAN_EID_DS_PARAMS to different place inside switch
      staging: ks7010: factor out send_request_to_device function
      staging: ks7010: fix some style issues in ks_hostif.c
      staging: ks7010: add blank line between after definitions
      staging: ks7010: refactor hostif_sme_set_rsn function
      staging: ks7010: change parameter types in hostif_power_mgmt_request
      staging: ks7010: refactor hostif_sme_power_mgmt_set function
      staging: ks7010: use ether_addr_copy in ks_wlan_set_mac_address
      staging: ks7010: use ether_addr_copy in ks_wlan_net_start
      staging: ks7010: refactor ks_wlan_set_sleep_mode function
      staging: ks7010: refactor ks_wlan_set_phy_type function
      staging: ks7010: refactor ks_wlan_set_mlme function
      staging: ks7010: refactor ks_get_wireless_stats function
      staging: ks7010: use CIRC_CNT_TO_END macro in cnt_smeqbody
      staging: ks7010: refactor LOCAL_EEPROM_SUM case in hostif_mib_get_confirm
      staging: ks7010: use u16 instead of unsigned short in hostif_event_check
      staging: ks7010: use u16 instead of unsigned short in hostif_data_indication
      staging: ks7010: use u16 instead of unsigned short in hostif_connect_indication
      staging: ks7010: use u32 instead of unsigned int in hostif_bss_scan_confirm
      staging: ks7010: review local variable types in hostif_phy_information_confirm
      staging: ks7010: remove not used definition WPA_CAPABILITY_PREAUTH
      staging: ks7010: remove no necessary blank line
      staging: ks7010: replace unsigned char type with u8
      staging: ks7010: change cast from uint16_t to u16
      staging: ks7010: change parameter type in ks_wlan_hw_rx function
      staging: ks7010: change uint8_t casts to u8 in ks_wlan_set_rate
      staging: ks7010: replace uint8_t with u8 in ks_wlan_set_tx_gain
      staging: ks7010: replace uint8_t with u8 in ks_wlan_set_rx_gain
      staging: ks7010: replace not standard uint type to unsigned int
      staging: ks7010: use u16 as type for casting in hostif_data_indication_wpa
      staging: ks7010: change some cast type from uint16_t to u16 in hostif_data_request
      staging: ks7010: change parameter type in hostif_mib_get_request
      staging: ks7010: avoid no needed cast in ks_wlan_cap
      staging: ks7010: use u16 as cast type in hostif_start_request
      staging: ks7010: replace casts to use type u16 in init_request
      staging: ks7010: use u16 as type for casting in hostif_ps_adhoc_set_request
      staging: ks7010: replace cast type in assignments in hostif_infrastructure_set_request
      staging: ks7010: replace cast type in assignment in hostif_adhoc_set_request
      staging: ks7010: replace cast types in assignments in hostif_phy_information_request
      staging: ks7010: replace uint* type into the u* ones in hostif_bss_scan_request
      staging: ks7010: change two parameter types in hostif_mic_failure_request
      staging: ks7010: use 'u16' for casts in assignments in hostif_sme_set_rsn
      staging: ks7010: replace cast type in assignment in hostif_sme_set_pmksa
      staging: mt7621-gpio: fix some warnings because of lines exceeded 80 characters
      staging: mt7621-gpio: add SPDX identifier
      staging: ks7010: avoid casting inside cpu_to_* assignments
      staging: mt7621-gpio: dt-bindings: add documentation for mt7621-gpio
      staging: mt7621-dts: update gpios related entries to use 'mediatek'
      staging: mt7621-gpio: replace 'mtk' to use correct one 'mediatek'
      staging: mt7621-gpio: avoid use of globals and use platform_data instead
      staging: mt7621-dts: add interrupt device tree nodes for the gpio controller
      staging: mt7621-gpio: dt-bindings: add interrupt nodes to bindings doc
      staging: mt7621-gpio: avoid devm_kzalloc() hidden inside declarations and refactor function a bit
      staging: mt7621-gpio: use ternary operator in return in mediatek_gpio_get_direction
      staging: mt7621-gpio: use MTK_BANK_WIDTH instead of magic number
      staging: mt7621-gpio: update TODO file
      staging: mt7621-gpio: rename MTK_MAX_BANK into MTK_BANK_CNT
      staging: mt7621-gpio: use module_platform_driver() instead subsys initcall
      staging: mt7621-gpio: fix masks for gpio pin
      staging: mt7621-gpio: avoid locking in mediatek_gpio_get_direction
      staging: mt7621-gpio: change lock place in irq mask and unmask functions
      staging: mt7621-dts: add missing properties to gpio node
      staging: mt7621-gpio: dt-bindings: complete documentation for the gpio
      staging: mt7621-gpio: update #interrupt-cells for the gpio node
      staging: mt7621-gpio: dt-bindings: update documentation for #interrupt-cells property
      staging: mt7621-gpio: change 'to_mediatek_gpio' to make just a one line return
      staging: mt7621-gpio: use GPIOF_DIR_OUT and GPIOF_DIR_IN macros instead of custom values
      staging: mt7621-gpio: change gc_map to don't use pointers
      staging: mt7621-gpio: reorder includes alphabetically

Shannon Booth (1):
      staging: pi433: Fixed typos and grammar in documentation

Shreeya Patel (6):
      Staging: iio: adis16209: Indent the field definitions
      Staging: iio: adis16209: Prefer reverse christmas tree ordering
      Staging: iio: adis16209: Add a blank line after return statements
      Staging: iio: adis16209: Remove unused headers
      Staging: iio: adis16209: Use GENMASK
      Staging: iio: adis16209: Move adis16209 driver out of staging

Sidong Yang (1):
      staging: rtl8723bs: Fix checkpatch.pl errors

Silvan Murer (2):
      iio: dac: fix missing of_match_table assignment in the LTC 2632 device
      iio: dac: Add support for external reference voltage through the regulator framework.

Simon Sandström (3):
      staging: pi433: break long lines
      staging: pi433: break long lines in rf69.c
      staging: pi433: break long lines in pi433_if.c

Stefan Popa (9):
      iio:dac:ad5686: Style fixes no functional changes
      iio:dac:ad5686: Change license description
      iio:dac:ad5686: Add support for various number of channels
      iio:dac:ad5686: Add support for AD5685R
      iio:dac:ad5686: Add AD5672R/76/76R/84R/86R support
      iio:dac:ad5686: Refactor the driver
      iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support
      iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support
      iio:dac:ad5686: Add AD5681R/AD5682R/AD5683/AD5683R support

Stefan Wahren (17):
      staging: vchiq_core: Fix missing semaphore release in error case
      staging: vchiq_core: Remove stackhog in process_free_queue
      staging: vchiq_core: remove BITSET_ZERO
      staging: vc04_services: Use __func__ macro
      staging: vchiq_arm: Fix multiline dereferences
      staging: vchiq_arm: Avoid long udelay
      staging: vchiq_core: Move all wake-ups to one point
      staging: vchiq_core: Free kthreads in error case
      staging: vchiq_arm: print real dump limit
      staging: vchiq_arm: Clear VLA warning
      staging: vchiq_arm: Rework second abort criterion
      staging: vchiq_arm: Make index variable more self-explaining
      staging: vc04_services: Remove defines from Makefile
      staging: vchiq_2835_arm: Fix whitespace issue in create_pagelist
      staging: vchiq_arm: remove unnecessary return
      staging: vchiq_shim: Remove unnecessary break
      staging: vc04_services: Remove stack hog issue from TODO

Sudip Mukherjee (1):
      staging: sm750fb: add drm development branch details

Tiezhu Yang (1):
      staging: rtlwifi: use single_open and single_release properly

Tim Collier (9):
      staging: wlan-ng: add missing parameter name to prototype
      staging: wlan-ng: fix line-break style issue
      staging: wlan-ng: fix SPDX comment style in headers
      staging: wlan-ng: fix block comment alignment in p80211metastruct.h
      staging: wlan-ng: fix coding style issues in p80211netdev.h
      staging: wlan-ng: fix coding style issues in p80211netdev.c
      staging: wlan-ng: convert P80211SKB_FRMMETA to inline function in p80211conv
      staging: wlan-ng: convert P80211SKB_RXMETA to inline function in p80211conv
      staging: wlan-ng: remove unused declarations from p80211types.h

Todd Poynor (1):
      staging: android: ion: remove duplicate buffer field initializes

Valentin Vidic (2):
      staging: pi433: cleanup tx_fifo locking
      staging: pi433: use help in Kconfig description

Vijayanand Jitta (1):
      ion: Consider ion pool pages as indirectly reclaimable

Vitaly Fertman (3):
      staging: lustre: obd: create it_has_reply_body()
      staging: lustre: obd: change debug reporting in lmv_enqueue()
      staging: lustre: ldlm: xattr locks are lost on mdt

Wenwen Wang (1):
      staging: lustre: llite: fix potential missing-check bug when copying lumv

William Breathitt Gray (1):
      iio: stx104: Implement get_multiple callback

Wolfram Sang (5):
      staging: nvec: simplify getting .drvdata
      staging: greybus: simplify getting .drvdata
      iio: common: cros_ec_sensors: simplify getting .drvdata
      iio: common: hid-sensors: simplify getting .drvdata
      staging: iio: adc: simplify getting .drvdata

Xingyu Chen (2):
      dt-bindings: iio: adc: document the Meson AXG support
      iio: adc: meson-saradc: add support for Meson AXG

Yangbo Lu (4):
      staging: fsl-dpaa2/rtc: add rtc driver
      MAINTAINERS: add maintainer for the DPAA2 PTP clock driver
      staging: fsl-dpaa2/eth: add the get_ts_info interface for ethtool
      staging: fsl-dpaa2/rtc: support phc_index of ethtool_ts_info

Yixun Lan (1):
      iio: adc: meson-saradc: squash and share the common adc platform data

ankit patel (1):
      Staging: goldfish: Kconfig: fixed code style issue

 Documentation/ABI/testing/sysfs-bus-iio            |    9 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    1 +
 .../devicetree/bindings/iio/adc/mcp320x.txt        |    2 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |    6 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |    7 +-
 .../bindings/iio/afe/current-sense-amplifier.txt   |   26 +
 .../bindings/iio/afe/current-sense-shunt.txt       |   41 +
 .../bindings/iio/afe/voltage-divider.txt           |   53 +
 .../devicetree/bindings/iio/dac/ltc2632.txt        |   14 +
 .../devicetree/bindings/iio/dac/ti,dac5571.txt     |   24 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   12 +-
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |    1 +
 .../bindings/iio/potentiostat/lmp91000.txt         |    9 +-
 Documentation/filesystems/00-INDEX                 |    2 -
 Documentation/filesystems/ncpfs.txt                |   12 -
 MAINTAINERS                                        |   32 +-
 drivers/iio/Kconfig                                |    2 +
 drivers/iio/Makefile                               |    2 +
 drivers/iio/accel/Kconfig                          |   24 +
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/adis16201.c                      |  321 ++
 drivers/{staging => }/iio/accel/adis16209.c        |   52 +-
 drivers/iio/accel/bmc150-accel-core.c              |   23 +-
 drivers/iio/accel/mma8452.c                        |   24 +-
 drivers/iio/accel/sca3000.c                        |   13 +-
 drivers/iio/accel/st_accel_i2c.c                   |    1 +
 drivers/iio/adc/ad7791.c                           |   87 +-
 drivers/iio/adc/imx7d_adc.c                        |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   83 +-
 drivers/iio/adc/stm32-adc-core.c                   |   66 +-
 drivers/iio/adc/stm32-adc.c                        |   47 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   17 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   26 +
 drivers/iio/adc/stx104.c                           |   11 +
 drivers/iio/adc/ti-ads8688.c                       |   48 +-
 drivers/iio/afe/Kconfig                            |   19 +
 drivers/iio/afe/Makefile                           |    6 +
 drivers/iio/afe/iio-rescale.c                      |  359 ++
 drivers/iio/amplifiers/ad8366.c                    |    6 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |   14 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    3 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    9 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    9 +-
 drivers/iio/dac/Kconfig                            |   33 +-
 drivers/iio/dac/Makefile                           |    3 +
 drivers/iio/dac/ad5686-spi.c                       |  119 +
 drivers/iio/dac/ad5686.c                           |  428 +-
 drivers/iio/dac/ad5686.h                           |  145 +
 drivers/iio/dac/ad5696-i2c.c                       |  102 +
 drivers/iio/dac/ltc2632.c                          |   89 +-
 drivers/iio/dac/ti-dac5571.c                       |  439 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  284 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   86 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   47 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   52 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   10 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/light/Kconfig                          |    8 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/cros_ec_light_prox.c             |    3 +-
 drivers/iio/light/tsl2583.c                        |    2 +-
 drivers/iio/light/tsl2772.c                        | 1800 ++++++++
 drivers/iio/magnetometer/mag3110.c                 |  158 +-
 drivers/iio/potentiometer/mcp4018.c                |   41 +-
 drivers/iio/potentiometer/mcp4531.c                |  145 +-
 drivers/iio/potentiostat/lmp91000.c                |    2 +
 drivers/iio/pressure/cros_ec_baro.c                |    3 +-
 drivers/iio/resolver/Kconfig                       |   17 +
 drivers/iio/resolver/Makefile                      |    5 +
 drivers/{staging => }/iio/resolver/ad2s1200.c      |  167 +-
 drivers/staging/Kconfig                            |    6 -
 drivers/staging/Makefile                           |    3 -
 drivers/staging/android/Kconfig                    |   11 +-
 drivers/staging/android/Makefile                   |    1 +
 drivers/staging/android/TODO                       |    9 +
 drivers/staging/android/ashmem.h                   |    6 +-
 drivers/staging/android/ion/Kconfig                |    2 +-
 drivers/staging/android/ion/ion.c                  |   22 +-
 drivers/staging/android/ion/ion.h                  |    2 +-
 drivers/staging/android/ion/ion_page_pool.c        |    5 +
 drivers/staging/android/uapi/ashmem.h              |    6 +-
 drivers/staging/android/uapi/ion.h                 |    2 +-
 drivers/staging/android/uapi/vsoc_shm.h            |  295 ++
 drivers/staging/android/vsoc.c                     | 1152 +++++
 drivers/staging/board/armadillo800eva.c            |   10 +-
 drivers/staging/board/board.c                      |    5 +-
 drivers/staging/comedi/comedi_compat32.c           |   12 +-
 drivers/staging/comedi/comedi_usb.h                |    5 +-
 drivers/staging/comedi/comedidev.h                 |    2 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |    6 +-
 drivers/staging/emxx_udc/Kconfig                   |    2 +-
 drivers/staging/emxx_udc/TODO                      |    2 +
 drivers/staging/fbtft/TODO                         |    4 +
 drivers/staging/fbtft/fbtft-bus.c                  |   13 +-
 drivers/staging/fsl-dpaa2/Kconfig                  |    8 +
 drivers/staging/fsl-dpaa2/Makefile                 |    5 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  111 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   49 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |   23 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h         |   13 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c             |   42 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h             |    6 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |   39 +-
 drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 +
 drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h          |  137 +
 drivers/staging/fsl-dpaa2/rtc/dprtc.c              |  701 +++
 drivers/staging/fsl-dpaa2/rtc/dprtc.h              |  164 +
 drivers/staging/fsl-dpaa2/rtc/rtc.c                |  229 +
 drivers/staging/fsl-dpaa2/rtc/rtc.h                |   14 +
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      |   28 +-
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h     |    4 +-
 drivers/staging/fsl-mc/include/dpaa2-io.h          |    2 +-
 drivers/staging/gdm724x/gdm_endian.c               |   14 +-
 drivers/staging/gdm724x/gdm_endian.h               |   14 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   16 +-
 drivers/staging/gdm724x/gdm_lte.h                  |   14 +-
 drivers/staging/gdm724x/gdm_mux.c                  |   14 +-
 drivers/staging/gdm724x/gdm_mux.h                  |   14 +-
 drivers/staging/gdm724x/gdm_tty.c                  |   14 +-
 drivers/staging/gdm724x/gdm_tty.h                  |   14 +-
 drivers/staging/gdm724x/gdm_usb.c                  |   14 +-
 drivers/staging/gdm724x/gdm_usb.h                  |   14 +-
 drivers/staging/gdm724x/hci.h                      |   14 +-
 drivers/staging/gdm724x/hci_packet.h               |   14 +-
 drivers/staging/gdm724x/netlink_k.c                |   14 +-
 drivers/staging/gdm724x/netlink_k.h                |   14 +-
 drivers/staging/goldfish/Kconfig                   |    9 +-
 drivers/staging/goldfish/Makefile                  |    1 -
 drivers/staging/goldfish/goldfish_nand.c           |  441 --
 drivers/staging/goldfish/goldfish_nand_reg.h       |   76 -
 drivers/staging/greybus/TODO                       |    5 +
 drivers/staging/greybus/arche-platform.c           |    9 +-
 drivers/staging/greybus/audio_codec.h              |    5 +-
 drivers/staging/greybus/audio_topology.c           |    2 +-
 drivers/staging/greybus/camera.c                   |   17 +-
 drivers/staging/greybus/svc.c                      |    3 -
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/TODO                           |    9 +-
 drivers/staging/iio/accel/Kconfig                  |   24 -
 drivers/staging/iio/accel/Makefile                 |    2 -
 drivers/staging/iio/accel/adis16201.c              |  385 --
 drivers/staging/iio/adc/ad7606_par.c               |    6 +-
 drivers/staging/iio/adc/ad7780.c                   |    2 +-
 drivers/staging/iio/cdc/ad7746.c                   |   44 +-
 drivers/staging/iio/light/Kconfig                  |   14 -
 drivers/staging/iio/light/Makefile                 |    5 -
 drivers/staging/iio/light/tsl2x7x.c                | 1889 ---------
 drivers/staging/iio/light/tsl2x7x.h                |   99 -
 drivers/staging/iio/meter/Kconfig                  |   42 -
 drivers/staging/iio/meter/Makefile                 |    8 -
 drivers/staging/iio/meter/ade7753.c                |  630 ---
 drivers/staging/iio/meter/ade7754.c                |  664 ---
 drivers/staging/iio/meter/ade7758.h                |  183 -
 drivers/staging/iio/meter/ade7758_core.c           |  955 -----
 drivers/staging/iio/meter/ade7758_ring.c           |  177 -
 drivers/staging/iio/meter/ade7758_trigger.c        |  108 -
 drivers/staging/iio/meter/ade7759.c                |  558 ---
 drivers/staging/iio/meter/ade7854-i2c.c            |  238 +-
 drivers/staging/iio/meter/ade7854-spi.c            |  268 +-
 drivers/staging/iio/meter/ade7854.c                |   40 +-
 drivers/staging/iio/meter/ade7854.h                |   16 +-
 drivers/staging/iio/resolver/Kconfig               |   12 -
 drivers/staging/iio/resolver/Makefile              |    1 -
 drivers/staging/ipx/Kconfig                        |   61 -
 drivers/staging/ipx/Makefile                       |    8 -
 drivers/staging/ipx/TODO                           |    4 -
 drivers/staging/ipx/af_ipx.c                       | 2082 ---------
 drivers/staging/ipx/ipx_proc.c                     |  338 --
 drivers/staging/ipx/ipx_route.c                    |  293 --
 drivers/staging/ipx/pe2.c                          |   36 -
 drivers/staging/ipx/sysctl_net_ipx.c               |   40 -
 drivers/staging/ks7010/eap_packet.h                |   76 +-
 drivers/staging/ks7010/ks7010_sdio.c               |  632 +--
 drivers/staging/ks7010/ks7010_sdio.h               |  164 -
 drivers/staging/ks7010/ks_hostif.c                 | 1043 ++---
 drivers/staging/ks7010/ks_hostif.h                 |  465 +-
 drivers/staging/ks7010/ks_wlan.h                   |  278 +-
 drivers/staging/ks7010/ks_wlan_ioctl.h             |    7 +-
 drivers/staging/ks7010/ks_wlan_net.c               | 1118 ++---
 drivers/staging/ks7010/michael_mic.c               |   28 +-
 drivers/staging/ks7010/michael_mic.h               |   11 +-
 drivers/staging/lustre/Kconfig                     |    3 -
 drivers/staging/lustre/Makefile                    |    2 -
 drivers/staging/lustre/README.txt                  |   83 -
 drivers/staging/lustre/TODO                        |  302 --
 .../staging/lustre/include/linux/libcfs/curproc.h  |   85 -
 .../staging/lustre/include/linux/libcfs/libcfs.h   |  135 -
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |  295 --
 .../lustre/include/linux/libcfs/libcfs_crypto.h    |  205 -
 .../lustre/include/linux/libcfs/libcfs_debug.h     |  167 -
 .../lustre/include/linux/libcfs/libcfs_fail.h      |  191 -
 .../lustre/include/linux/libcfs/libcfs_hash.h      |  866 ----
 .../lustre/include/linux/libcfs/libcfs_prim.h      |   82 -
 .../lustre/include/linux/libcfs/libcfs_private.h   |  200 -
 .../lustre/include/linux/libcfs/libcfs_string.h    |  100 -
 .../lustre/include/linux/libcfs/libcfs_time.h      |   79 -
 .../lustre/include/linux/libcfs/linux/libcfs.h     |  133 -
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |   78 -
 .../lustre/include/linux/libcfs/linux/linux-time.h |  103 -
 drivers/staging/lustre/include/linux/lnet/api.h    |  212 -
 .../staging/lustre/include/linux/lnet/lib-lnet.h   |  644 ---
 .../staging/lustre/include/linux/lnet/lib-types.h  |  666 ---
 .../staging/lustre/include/linux/lnet/socklnd.h    |   87 -
 .../lustre/include/uapi/linux/lnet/libcfs_debug.h  |  149 -
 .../lustre/include/uapi/linux/lnet/libcfs_ioctl.h  |  141 -
 .../lustre/include/uapi/linux/lnet/lnet-dlc.h      |  149 -
 .../lustre/include/uapi/linux/lnet/lnet-types.h    |  669 ---
 .../lustre/include/uapi/linux/lnet/lnetctl.h       |  134 -
 .../lustre/include/uapi/linux/lnet/lnetst.h        |  556 ---
 .../lustre/include/uapi/linux/lnet/nidstr.h        |  119 -
 .../lustre/include/uapi/linux/lnet/socklnd.h       |   44 -
 .../lustre/include/uapi/linux/lustre/lustre_cfg.h  |  261 --
 .../lustre/include/uapi/linux/lustre/lustre_fid.h  |  293 --
 .../include/uapi/linux/lustre/lustre_fiemap.h      |   72 -
 .../lustre/include/uapi/linux/lustre/lustre_idl.h  | 2688 ------------
 .../include/uapi/linux/lustre/lustre_ioctl.h       |  231 -
 .../include/uapi/linux/lustre/lustre_kernelcomm.h  |   94 -
 .../include/uapi/linux/lustre/lustre_ostid.h       |  236 --
 .../include/uapi/linux/lustre/lustre_param.h       |   94 -
 .../lustre/include/uapi/linux/lustre/lustre_user.h | 1325 ------
 .../lustre/include/uapi/linux/lustre/lustre_ver.h  |   27 -
 drivers/staging/lustre/lnet/Kconfig                |   46 -
 drivers/staging/lustre/lnet/Makefile               |    1 -
 drivers/staging/lustre/lnet/klnds/Makefile         |    1 -
 drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile |    5 -
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    | 2952 -------------
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    | 1038 -----
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 3751 ----------------
 .../lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c  |  287 --
 drivers/staging/lustre/lnet/klnds/socklnd/Makefile |    6 -
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    | 2918 -------------
 .../staging/lustre/lnet/klnds/socklnd/socklnd.h    |  705 ----
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c | 2592 ------------
 .../lustre/lnet/klnds/socklnd/socklnd_lib.c        |  533 ---
 .../lustre/lnet/klnds/socklnd/socklnd_modparams.c  |  184 -
 .../lustre/lnet/klnds/socklnd/socklnd_proto.c      |  810 ----
 drivers/staging/lustre/lnet/libcfs/Makefile        |   19 -
 drivers/staging/lustre/lnet/libcfs/debug.c         |  458 --
 drivers/staging/lustre/lnet/libcfs/fail.c          |  142 -
 drivers/staging/lustre/lnet/libcfs/hash.c          | 2064 ---------
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |  228 -
 drivers/staging/lustre/lnet/libcfs/libcfs_lock.c   |  152 -
 drivers/staging/lustre/lnet/libcfs/libcfs_mem.c    |  167 -
 drivers/staging/lustre/lnet/libcfs/libcfs_string.c |  556 ---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 1079 -----
 .../lustre/lnet/libcfs/linux/linux-crypto-adler.c  |  139 -
 .../lustre/lnet/libcfs/linux/linux-crypto.c        |  443 --
 .../lustre/lnet/libcfs/linux/linux-crypto.h        |   30 -
 .../staging/lustre/lnet/libcfs/linux/linux-debug.c |  145 -
 .../lustre/lnet/libcfs/linux/linux-module.c        |  197 -
 .../lustre/lnet/libcfs/linux/linux-tracefile.c     |  257 --
 drivers/staging/lustre/lnet/libcfs/module.c        |  604 ---
 drivers/staging/lustre/lnet/libcfs/tracefile.c     | 1191 ------
 drivers/staging/lustre/lnet/libcfs/tracefile.h     |  263 --
 drivers/staging/lustre/lnet/lnet/Makefile          |   10 -
 drivers/staging/lustre/lnet/lnet/acceptor.c        |  501 ---
 drivers/staging/lustre/lnet/lnet/api-ni.c          | 2307 ----------
 drivers/staging/lustre/lnet/lnet/config.c          | 1234 ------
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |  426 --
 drivers/staging/lustre/lnet/lnet/lib-md.c          |  463 --
 drivers/staging/lustre/lnet/lnet/lib-me.c          |  274 --
 drivers/staging/lustre/lnet/lnet/lib-move.c        | 2388 -----------
 drivers/staging/lustre/lnet/lnet/lib-msg.c         |  625 ---
 drivers/staging/lustre/lnet/lnet/lib-ptl.c         |  987 -----
 drivers/staging/lustre/lnet/lnet/lib-socket.c      |  586 ---
 drivers/staging/lustre/lnet/lnet/lo.c              |  105 -
 drivers/staging/lustre/lnet/lnet/module.c          |  223 -
 drivers/staging/lustre/lnet/lnet/net_fault.c       | 1023 -----
 drivers/staging/lustre/lnet/lnet/nidstrings.c      | 1258 ------
 drivers/staging/lustre/lnet/lnet/peer.c            |  456 --
 drivers/staging/lustre/lnet/lnet/router.c          | 1800 --------
 drivers/staging/lustre/lnet/lnet/router_proc.c     |  909 ----
 drivers/staging/lustre/lnet/selftest/Makefile      |    7 -
 drivers/staging/lustre/lnet/selftest/brw_test.c    |  526 ---
 drivers/staging/lustre/lnet/selftest/conctl.c      |  799 ----
 drivers/staging/lustre/lnet/selftest/conrpc.c      | 1397 ------
 drivers/staging/lustre/lnet/selftest/conrpc.h      |  143 -
 drivers/staging/lustre/lnet/selftest/console.c     | 2101 ---------
 drivers/staging/lustre/lnet/selftest/console.h     |  244 --
 drivers/staging/lustre/lnet/selftest/framework.c   | 1786 --------
 drivers/staging/lustre/lnet/selftest/module.c      |  165 -
 drivers/staging/lustre/lnet/selftest/ping_test.c   |  228 -
 drivers/staging/lustre/lnet/selftest/rpc.c         | 1682 --------
 drivers/staging/lustre/lnet/selftest/rpc.h         |  295 --
 drivers/staging/lustre/lnet/selftest/selftest.h    |  623 ---
 drivers/staging/lustre/lnet/selftest/timer.c       |  244 --
 drivers/staging/lustre/lnet/selftest/timer.h       |   50 -
 drivers/staging/lustre/lustre/Kconfig              |   45 -
 drivers/staging/lustre/lustre/Makefile             |    2 -
 drivers/staging/lustre/lustre/fid/Makefile         |    5 -
 drivers/staging/lustre/lustre/fid/fid_internal.h   |   47 -
 drivers/staging/lustre/lustre/fid/fid_lib.c        |   88 -
 drivers/staging/lustre/lustre/fid/fid_request.c    |  440 --
 drivers/staging/lustre/lustre/fid/lproc_fid.c      |  226 -
 drivers/staging/lustre/lustre/fld/Makefile         |    5 -
 drivers/staging/lustre/lustre/fld/fld_cache.c      |  517 ---
 drivers/staging/lustre/lustre/fld/fld_internal.h   |  171 -
 drivers/staging/lustre/lustre/fld/fld_request.c    |  471 ---
 drivers/staging/lustre/lustre/fld/lproc_fld.c      |  155 -
 drivers/staging/lustre/lustre/include/cl_object.h  | 2463 -----------
 .../staging/lustre/lustre/include/interval_tree.h  |  119 -
 drivers/staging/lustre/lustre/include/llog_swab.h  |   67 -
 .../staging/lustre/lustre/include/lprocfs_status.h |  672 ---
 drivers/staging/lustre/lustre/include/lu_object.h  | 1335 ------
 drivers/staging/lustre/lustre/include/lu_ref.h     |  178 -
 drivers/staging/lustre/lustre/include/lustre_acl.h |   46 -
 .../staging/lustre/lustre/include/lustre_compat.h  |   81 -
 .../staging/lustre/lustre/include/lustre_debug.h   |   52 -
 .../staging/lustre/lustre/include/lustre_disk.h    |  153 -
 drivers/staging/lustre/lustre/include/lustre_dlm.h | 1354 ------
 .../lustre/lustre/include/lustre_dlm_flags.h       |  402 --
 .../staging/lustre/lustre/include/lustre_errno.h   |  198 -
 .../staging/lustre/lustre/include/lustre_export.h  |  257 --
 drivers/staging/lustre/lustre/include/lustre_fid.h |  676 ---
 drivers/staging/lustre/lustre/include/lustre_fld.h |  138 -
 drivers/staging/lustre/lustre/include/lustre_ha.h  |   61 -
 .../staging/lustre/lustre/include/lustre_handles.h |   93 -
 .../staging/lustre/lustre/include/lustre_import.h  |  368 --
 .../staging/lustre/lustre/include/lustre_intent.h  |   69 -
 .../lustre/lustre/include/lustre_kernelcomm.h      |   56 -
 drivers/staging/lustre/lustre/include/lustre_lib.h |  124 -
 .../staging/lustre/lustre/include/lustre_linkea.h  |   93 -
 drivers/staging/lustre/lustre/include/lustre_lmv.h |  174 -
 drivers/staging/lustre/lustre/include/lustre_log.h |  382 --
 drivers/staging/lustre/lustre/include/lustre_mdc.h |  229 -
 drivers/staging/lustre/lustre/include/lustre_mds.h |   63 -
 drivers/staging/lustre/lustre/include/lustre_net.h | 2359 -----------
 drivers/staging/lustre/lustre/include/lustre_nrs.h |  718 ----
 .../lustre/lustre/include/lustre_nrs_fifo.h        |   71 -
 .../staging/lustre/lustre/include/lustre_obdo.h    |   55 -
 .../lustre/include/lustre_patchless_compat.h       |   67 -
 .../lustre/lustre/include/lustre_req_layout.h      |  307 --
 drivers/staging/lustre/lustre/include/lustre_sec.h | 1070 -----
 .../staging/lustre/lustre/include/lustre_swab.h    |  109 -
 drivers/staging/lustre/lustre/include/obd.h        | 1101 -----
 drivers/staging/lustre/lustre/include/obd_cksum.h  |  153 -
 drivers/staging/lustre/lustre/include/obd_class.h  | 1607 -------
 .../staging/lustre/lustre/include/obd_support.h    |  545 ---
 drivers/staging/lustre/lustre/include/seq_range.h  |  200 -
 drivers/staging/lustre/lustre/ldlm/interval_tree.c |  599 ---
 drivers/staging/lustre/lustre/ldlm/l_lock.c        |   74 -
 drivers/staging/lustre/lustre/ldlm/ldlm_extent.c   |  259 --
 drivers/staging/lustre/lustre/ldlm/ldlm_flock.c    |  495 ---
 .../staging/lustre/lustre/ldlm/ldlm_inodebits.c    |   69 -
 drivers/staging/lustre/lustre/ldlm/ldlm_internal.h |  342 --
 drivers/staging/lustre/lustre/ldlm/ldlm_lib.c      |  843 ----
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     | 2146 ----------
 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    | 1163 -----
 drivers/staging/lustre/lustre/ldlm/ldlm_plain.c    |   68 -
 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c     | 1023 -----
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  | 2080 ---------
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c | 1369 ------
 drivers/staging/lustre/lustre/llite/Makefile       |   11 -
 drivers/staging/lustre/lustre/llite/dcache.c       |  300 --
 drivers/staging/lustre/lustre/llite/dir.c          | 1706 --------
 drivers/staging/lustre/lustre/llite/file.c         | 3600 ----------------
 drivers/staging/lustre/lustre/llite/glimpse.c      |  206 -
 drivers/staging/lustre/lustre/llite/lcommon_cl.c   |  293 --
 drivers/staging/lustre/lustre/llite/lcommon_misc.c |  186 -
 .../staging/lustre/lustre/llite/llite_internal.h   | 1337 ------
 drivers/staging/lustre/lustre/llite/llite_lib.c    | 2666 ------------
 drivers/staging/lustre/lustre/llite/llite_mmap.c   |  478 ---
 drivers/staging/lustre/lustre/llite/llite_nfs.c    |  375 --
 drivers/staging/lustre/lustre/llite/lproc_llite.c  | 1684 --------
 drivers/staging/lustre/lustre/llite/namei.c        | 1202 ------
 drivers/staging/lustre/lustre/llite/range_lock.c   |  240 --
 drivers/staging/lustre/lustre/llite/range_lock.h   |   83 -
 drivers/staging/lustre/lustre/llite/rw.c           | 1214 ------
 drivers/staging/lustre/lustre/llite/rw26.c         |  641 ---
 drivers/staging/lustre/lustre/llite/statahead.c    | 1577 -------
 drivers/staging/lustre/lustre/llite/super25.c      |  185 -
 drivers/staging/lustre/lustre/llite/symlink.c      |  159 -
 drivers/staging/lustre/lustre/llite/vvp_dev.c      |  659 ---
 drivers/staging/lustre/lustre/llite/vvp_internal.h |  321 --
 drivers/staging/lustre/lustre/llite/vvp_io.c       | 1374 ------
 drivers/staging/lustre/lustre/llite/vvp_lock.c     |   87 -
 drivers/staging/lustre/lustre/llite/vvp_object.c   |  305 --
 drivers/staging/lustre/lustre/llite/vvp_page.c     |  523 ---
 drivers/staging/lustre/lustre/llite/xattr.c        |  638 ---
 drivers/staging/lustre/lustre/llite/xattr_cache.c  |  523 ---
 .../staging/lustre/lustre/llite/xattr_security.c   |   96 -
 drivers/staging/lustre/lustre/lmv/Makefile         |    5 -
 drivers/staging/lustre/lustre/lmv/lmv_fld.c        |   82 -
 drivers/staging/lustre/lustre/lmv/lmv_intent.c     |  517 ---
 drivers/staging/lustre/lustre/lmv/lmv_internal.h   |  164 -
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        | 3131 --------------
 drivers/staging/lustre/lustre/lmv/lproc_lmv.c      |  173 -
 drivers/staging/lustre/lustre/lov/Makefile         |    9 -
 .../staging/lustre/lustre/lov/lov_cl_internal.h    |  641 ---
 drivers/staging/lustre/lustre/lov/lov_dev.c        |  384 --
 drivers/staging/lustre/lustre/lov/lov_ea.c         |  332 --
 drivers/staging/lustre/lustre/lov/lov_internal.h   |  283 --
 drivers/staging/lustre/lustre/lov/lov_io.c         | 1023 -----
 drivers/staging/lustre/lustre/lov/lov_lock.c       |  348 --
 drivers/staging/lustre/lustre/lov/lov_merge.c      |  107 -
 drivers/staging/lustre/lustre/lov/lov_obd.c        | 1448 -------
 drivers/staging/lustre/lustre/lov/lov_object.c     | 1625 -------
 drivers/staging/lustre/lustre/lov/lov_offset.c     |  271 --
 drivers/staging/lustre/lustre/lov/lov_pack.c       |  400 --
 drivers/staging/lustre/lustre/lov/lov_page.c       |  136 -
 drivers/staging/lustre/lustre/lov/lov_pool.c       |  586 ---
 drivers/staging/lustre/lustre/lov/lov_request.c    |  356 --
 drivers/staging/lustre/lustre/lov/lovsub_dev.c     |  147 -
 drivers/staging/lustre/lustre/lov/lovsub_lock.c    |   81 -
 drivers/staging/lustre/lustre/lov/lovsub_object.c  |  180 -
 drivers/staging/lustre/lustre/lov/lovsub_page.c    |   68 -
 drivers/staging/lustre/lustre/lov/lproc_lov.c      |  299 --
 drivers/staging/lustre/lustre/mdc/Makefile         |    5 -
 drivers/staging/lustre/lustre/mdc/lproc_mdc.c      |  231 -
 drivers/staging/lustre/lustre/mdc/mdc_internal.h   |  144 -
 drivers/staging/lustre/lustre/mdc/mdc_lib.c        |  497 ---
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      | 1202 ------
 drivers/staging/lustre/lustre/mdc/mdc_reint.c      |  419 --
 drivers/staging/lustre/lustre/mdc/mdc_request.c    | 2754 ------------
 drivers/staging/lustre/lustre/mgc/Makefile         |    5 -
 drivers/staging/lustre/lustre/mgc/lproc_mgc.c      |   69 -
 drivers/staging/lustre/lustre/mgc/mgc_internal.h   |   58 -
 drivers/staging/lustre/lustre/mgc/mgc_request.c    | 1844 --------
 drivers/staging/lustre/lustre/obdclass/Makefile    |   12 -
 .../staging/lustre/lustre/obdclass/cl_internal.h   |   95 -
 drivers/staging/lustre/lustre/obdclass/cl_io.c     | 1152 -----
 drivers/staging/lustre/lustre/obdclass/cl_lock.c   |  275 --
 drivers/staging/lustre/lustre/obdclass/cl_object.c | 1061 -----
 drivers/staging/lustre/lustre/obdclass/cl_page.c   | 1046 -----
 drivers/staging/lustre/lustre/obdclass/class_obd.c |  535 ---
 drivers/staging/lustre/lustre/obdclass/debug.c     |   96 -
 drivers/staging/lustre/lustre/obdclass/genops.c    | 1514 -------
 .../staging/lustre/lustre/obdclass/kernelcomm.c    |  238 --
 drivers/staging/lustre/lustre/obdclass/linkea.c    |  249 --
 .../lustre/lustre/obdclass/linux/linux-module.c    |  531 ---
 .../lustre/lustre/obdclass/linux/linux-sysctl.c    |  162 -
 drivers/staging/lustre/lustre/obdclass/llog.c      |  523 ---
 drivers/staging/lustre/lustre/obdclass/llog_cat.c  |  236 --
 .../staging/lustre/lustre/obdclass/llog_internal.h |   79 -
 drivers/staging/lustre/lustre/obdclass/llog_obd.c  |  225 -
 drivers/staging/lustre/lustre/obdclass/llog_swab.c |  412 --
 .../lustre/lustre/obdclass/lprocfs_counters.c      |  133 -
 .../lustre/lustre/obdclass/lprocfs_status.c        | 1810 --------
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 2058 ---------
 drivers/staging/lustre/lustre/obdclass/lu_ref.c    |   47 -
 .../lustre/lustre/obdclass/lustre_handles.c        |  240 --
 .../staging/lustre/lustre/obdclass/lustre_peer.c   |  214 -
 .../staging/lustre/lustre/obdclass/obd_config.c    | 1559 -------
 drivers/staging/lustre/lustre/obdclass/obd_mount.c | 1244 ------
 drivers/staging/lustre/lustre/obdclass/obdo.c      |  181 -
 .../staging/lustre/lustre/obdclass/statfs_pack.c   |   58 -
 drivers/staging/lustre/lustre/obdclass/uuid.c      |   47 -
 drivers/staging/lustre/lustre/obdecho/Makefile     |    5 -
 .../staging/lustre/lustre/obdecho/echo_client.c    | 1724 --------
 .../staging/lustre/lustre/obdecho/echo_internal.h  |   42 -
 drivers/staging/lustre/lustre/osc/Makefile         |    6 -
 drivers/staging/lustre/lustre/osc/lproc_osc.c      |  843 ----
 drivers/staging/lustre/lustre/osc/osc_cache.c      | 3306 ---------------
 .../staging/lustre/lustre/osc/osc_cl_internal.h    |  683 ---
 drivers/staging/lustre/lustre/osc/osc_dev.c        |  246 --
 drivers/staging/lustre/lustre/osc/osc_internal.h   |  236 --
 drivers/staging/lustre/lustre/osc/osc_io.c         |  918 ----
 drivers/staging/lustre/lustre/osc/osc_lock.c       | 1231 ------
 drivers/staging/lustre/lustre/osc/osc_object.c     |  474 ---
 drivers/staging/lustre/lustre/osc/osc_page.c       | 1094 -----
 drivers/staging/lustre/lustre/osc/osc_quota.c      |  284 --
 drivers/staging/lustre/lustre/osc/osc_request.c    | 2899 -------------
 drivers/staging/lustre/lustre/ptlrpc/Makefile      |   23 -
 drivers/staging/lustre/lustre/ptlrpc/client.c      | 3269 --------------
 drivers/staging/lustre/lustre/ptlrpc/connection.c  |  234 -
 drivers/staging/lustre/lustre/ptlrpc/errno.c       |  381 --
 drivers/staging/lustre/lustre/ptlrpc/events.c      |  585 ---
 drivers/staging/lustre/lustre/ptlrpc/import.c      | 1676 --------
 drivers/staging/lustre/lustre/ptlrpc/layout.c      | 2234 ----------
 drivers/staging/lustre/lustre/ptlrpc/llog_client.c |  340 --
 drivers/staging/lustre/lustre/ptlrpc/llog_net.c    |   69 -
 .../staging/lustre/lustre/ptlrpc/lproc_ptlrpc.c    | 1332 ------
 drivers/staging/lustre/lustre/ptlrpc/niobuf.c      |  770 ----
 drivers/staging/lustre/lustre/ptlrpc/nrs.c         | 1612 -------
 drivers/staging/lustre/lustre/ptlrpc/nrs_fifo.c    |  269 --
 .../staging/lustre/lustre/ptlrpc/pack_generic.c    | 2313 ----------
 drivers/staging/lustre/lustre/ptlrpc/pers.c        |   72 -
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |  477 ---
 .../staging/lustre/lustre/ptlrpc/ptlrpc_internal.h |  371 --
 .../staging/lustre/lustre/ptlrpc/ptlrpc_module.c   |  182 -
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |  912 ----
 drivers/staging/lustre/lustre/ptlrpc/recover.c     |  374 --
 drivers/staging/lustre/lustre/ptlrpc/sec.c         | 2383 -----------
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |  572 ---
 drivers/staging/lustre/lustre/ptlrpc/sec_config.c  |  850 ----
 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c      |  190 -
 drivers/staging/lustre/lustre/ptlrpc/sec_lproc.c   |  195 -
 drivers/staging/lustre/lustre/ptlrpc/sec_null.c    |  459 --
 drivers/staging/lustre/lustre/ptlrpc/sec_plain.c   | 1023 -----
 drivers/staging/lustre/lustre/ptlrpc/service.c     | 2804 ------------
 drivers/staging/lustre/lustre/ptlrpc/wiretest.c    | 4210 ------------------
 drivers/staging/lustre/sysfs-fs-lustre             |  654 ---
 drivers/staging/media/atomisp/TODO                 |    5 +
 drivers/staging/most/cdev/cdev.c                   |   16 +-
 drivers/staging/most/core.c                        |   68 +-
 drivers/staging/most/core.h                        |    4 +
 drivers/staging/most/dim2/Kconfig                  |    2 +-
 drivers/staging/most/dim2/dim2.c                   |  397 +-
 drivers/staging/most/dim2/dim2.h                   |   21 -
 drivers/staging/most/dim2/hal.c                    |    9 +-
 drivers/staging/most/dim2/reg.h                    |   84 +-
 drivers/staging/most/i2c/i2c.c                     |  140 +-
 drivers/staging/most/sound/sound.c                 |  123 +-
 drivers/staging/most/usb/usb.c                     |   55 +-
 drivers/staging/most/video/video.c                 |   32 -
 drivers/staging/mt7621-dts/gbpc1.dts               |    3 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |   24 +-
 drivers/staging/mt7621-eth/ethtool.c               |   54 +-
 drivers/staging/mt7621-eth/gsw_mt7620.h            |    4 +-
 drivers/staging/mt7621-eth/gsw_mt7621.c            |   10 +-
 drivers/staging/mt7621-eth/mdio.c                  |    6 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |   44 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.h           |   33 +-
 drivers/staging/mt7621-eth/soc_mt7621.c            |    7 +-
 drivers/staging/mt7621-gpio/TODO                   |    2 -
 drivers/staging/mt7621-gpio/gpio-mt7621.c          |  200 +-
 .../staging/mt7621-gpio/mediatek,mt7621-gpio.txt   |   68 +
 drivers/staging/mt7621-mmc/board.h                 |   82 +-
 drivers/staging/mt7621-mmc/dbg.c                   |  398 +-
 drivers/staging/mt7621-mmc/dbg.h                   |   97 +-
 drivers/staging/mt7621-mmc/mt6575_sd.h             | 1087 +++--
 drivers/staging/mt7621-mmc/sd.c                    | 4458 +++++++++-----------
 drivers/staging/mt7621-pci/pci-mt7621.c            |  481 +--
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |    1 -
 drivers/staging/mt7621-spi/spi-mt7621.c            |    4 -
 drivers/staging/ncpfs/Kconfig                      |  108 -
 drivers/staging/ncpfs/Makefile                     |   17 -
 drivers/staging/ncpfs/TODO                         |    4 -
 drivers/staging/ncpfs/dir.c                        | 1232 ------
 drivers/staging/ncpfs/file.c                       |  263 --
 drivers/staging/ncpfs/getopt.c                     |   76 -
 drivers/staging/ncpfs/getopt.h                     |   17 -
 drivers/staging/ncpfs/inode.c                      | 1067 -----
 drivers/staging/ncpfs/ioctl.c                      |  923 ----
 drivers/staging/ncpfs/mmap.c                       |  125 -
 drivers/staging/ncpfs/ncp_fs.h                     |  101 -
 drivers/staging/ncpfs/ncp_fs_i.h                   |   31 -
 drivers/staging/ncpfs/ncp_fs_sb.h                  |  174 -
 drivers/staging/ncpfs/ncplib_kernel.c              | 1326 ------
 drivers/staging/ncpfs/ncplib_kernel.h              |  215 -
 drivers/staging/ncpfs/ncpsign_kernel.c             |  128 -
 drivers/staging/ncpfs/ncpsign_kernel.h             |   27 -
 drivers/staging/ncpfs/sock.c                       |  855 ----
 drivers/staging/ncpfs/symlink.c                    |  182 -
 drivers/staging/nvec/nvec.c                        |   81 +-
 drivers/staging/nvec/nvec.h                        |    2 +-
 drivers/staging/olpc_dcon/TODO                     |    4 +
 .../pi433/Documentation/devicetree/pi433.txt       |    6 +-
 drivers/staging/pi433/Documentation/pi433.txt      |   10 +-
 drivers/staging/pi433/Kconfig                      |    2 +-
 drivers/staging/pi433/pi433_if.c                   |   39 +-
 drivers/staging/pi433/rf69.c                       |  182 +-
 drivers/staging/pi433/rf69.h                       |   28 +-
 drivers/staging/rtl8188eu/TODO                     |    5 -
 drivers/staging/rtl8188eu/core/rtw_ap.c            |   72 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   26 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   20 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |    2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   38 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |  100 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |   34 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |   16 +-
 drivers/staging/rtl8188eu/include/wlan_bssdef.h    |   10 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   12 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c      |    4 -
 drivers/staging/rtl8192e/dot11d.c                  |    2 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |   14 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |    2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |    2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c       |    2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |    2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    |  467 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    2 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |    4 +-
 drivers/staging/rtl8723bs/Makefile                 |    2 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   10 +-
 drivers/staging/rtl8723bs/core/rtw_btcoex.c        |   10 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   10 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |   10 +-
 drivers/staging/rtl8723bs/core/rtw_eeprom.c        |   10 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   10 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |   10 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |   10 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |   10 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   10 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   10 +-
 drivers/staging/rtl8723bs/core/rtw_odm.c           |   10 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |   10 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   10 +-
 drivers/staging/rtl8723bs/core/rtw_rf.c            |   10 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |   10 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   10 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |   10 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   10 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    |   10 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h    |   10 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    |   12 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h    |   10 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.h   |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c  |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.h  |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.h   |   10 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |   10 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.h           |   10 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |   10 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h     |   10 +-
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |   10 +-
 drivers/staging/rtl8723bs/hal/Mp_Precomp.h         |   10 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |   10 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |   10 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |   10 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c           |   10 +-
 drivers/staging/rtl8723bs/hal/hal_phy.c            |   10 +-
 .../hal/{Hal8723BPwrSeq.c => hal_pwr_seq.c}        |   12 +-
 drivers/staging/rtl8723bs/hal/hal_sdio.c           |   10 +-
 drivers/staging/rtl8723bs/hal/odm.c                |   10 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   10 +-
 drivers/staging/rtl8723bs/hal/odm_AntDiv.c         |   10 +-
 drivers/staging/rtl8723bs/hal/odm_AntDiv.h         |   10 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |   10 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.h    |   10 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |   10 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.h            |   10 +-
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.c       |   10 +-
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.h       |   10 +-
 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.c |   10 +-
 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.h |   10 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |   10 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.h |   10 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |   10 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h       |   10 +-
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c   |   10 +-
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h   |   10 +-
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c        |   10 +-
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h        |   10 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c       |   10 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h       |   10 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c |   10 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h |   10 +-
 drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h   |   10 +-
 drivers/staging/rtl8723bs/hal/odm_debug.c          |   10 +-
 drivers/staging/rtl8723bs/hal/odm_debug.h          |   10 +-
 drivers/staging/rtl8723bs/hal/odm_interface.h      |   10 +-
 drivers/staging/rtl8723bs/hal/odm_precomp.h        |   10 +-
 drivers/staging/rtl8723bs/hal/odm_reg.h            |   10 +-
 drivers/staging/rtl8723bs/hal/odm_types.h          |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   40 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c    |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c    |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |   10 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |   10 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   10 +-
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h |   10 +-
 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h   |   10 +-
 drivers/staging/rtl8723bs/include/HalVerDef.h      |   10 +-
 drivers/staging/rtl8723bs/include/autoconf.h       |   10 +-
 drivers/staging/rtl8723bs/include/basic_types.h    |   10 +-
 drivers/staging/rtl8723bs/include/cmd_osdep.h      |   10 +-
 drivers/staging/rtl8723bs/include/drv_conf.h       |   10 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |   10 +-
 drivers/staging/rtl8723bs/include/drv_types_sdio.h |   10 +-
 drivers/staging/rtl8723bs/include/ethernet.h       |   10 +-
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |   10 +-
 drivers/staging/rtl8723bs/include/hal_com.h        |   10 +-
 drivers/staging/rtl8723bs/include/hal_com_h2c.h    |   10 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |   10 +-
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |   10 +-
 drivers/staging/rtl8723bs/include/hal_data.h       |   10 +-
 drivers/staging/rtl8723bs/include/hal_intf.h       |   10 +-
 drivers/staging/rtl8723bs/include/hal_pg.h         |   10 +-
 drivers/staging/rtl8723bs/include/hal_phy.h        |   10 +-
 .../include/{Hal8723BPhyCfg.h => hal_phy_cfg.h}    |   10 +-
 drivers/staging/rtl8723bs/include/hal_phy_reg.h    |   10 +-
 .../{Hal8723BPhyReg.h => hal_phy_reg_8723b.h}      |   10 +-
 .../include/{Hal8723BPwrSeq.h => hal_pwr_seq.h}    |    0
 drivers/staging/rtl8723bs/include/hal_sdio.h       |   10 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |   10 +-
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |   10 +-
 drivers/staging/rtl8723bs/include/mlme_osdep.h     |   10 +-
 drivers/staging/rtl8723bs/include/osdep_intf.h     |   10 +-
 drivers/staging/rtl8723bs/include/osdep_service.h  |   10 +-
 .../rtl8723bs/include/osdep_service_linux.h        |   10 +-
 drivers/staging/rtl8723bs/include/recv_osdep.h     |   10 +-
 drivers/staging/rtl8723bs/include/rtl8192c_recv.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtl8192c_rf.h    |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h   |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_dm.h    |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |  283 +-
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_rf.h    |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_spec.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtw_ap.h         |   10 +-
 .../staging/rtl8723bs/include/rtw_beamforming.h    |   10 +-
 drivers/staging/rtl8723bs/include/rtw_br_ext.h     |   10 +-
 drivers/staging/rtl8723bs/include/rtw_btcoex.h     |   10 +-
 drivers/staging/rtl8723bs/include/rtw_byteorder.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |   10 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h      |   10 +-
 drivers/staging/rtl8723bs/include/rtw_eeprom.h     |   10 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |   10 +-
 drivers/staging/rtl8723bs/include/rtw_event.h      |   10 +-
 drivers/staging/rtl8723bs/include/rtw_ht.h         |   10 +-
 drivers/staging/rtl8723bs/include/rtw_io.h         |   10 +-
 drivers/staging/rtl8723bs/include/rtw_ioctl.h      |   10 +-
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h  |   10 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |   10 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |   10 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h         |   10 +-
 drivers/staging/rtl8723bs/include/rtw_odm.h        |   10 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h    |   35 +-
 drivers/staging/rtl8723bs/include/rtw_qos.h        |   10 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   10 +-
 drivers/staging/rtl8723bs/include/rtw_rf.h         |   10 +-
 drivers/staging/rtl8723bs/include/rtw_security.h   |   10 +-
 drivers/staging/rtl8723bs/include/rtw_version.h    |    1 +
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |   10 +-
 drivers/staging/rtl8723bs/include/sdio_hal.h       |   10 +-
 drivers/staging/rtl8723bs/include/sdio_ops.h       |   10 +-
 drivers/staging/rtl8723bs/include/sdio_ops_linux.h |   10 +-
 drivers/staging/rtl8723bs/include/sdio_osintf.h    |   10 +-
 drivers/staging/rtl8723bs/include/sta_info.h       |   10 +-
 drivers/staging/rtl8723bs/include/wifi.h           |   22 +-
 drivers/staging/rtl8723bs/include/wlan_bssdef.h    |   10 +-
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |   10 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   12 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   10 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |   10 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   10 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |   10 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |   10 +-
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c        |   10 +-
 drivers/staging/rtl8723bs/os_dep/rtw_proc.h        |   10 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |   10 +-
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |   10 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   10 +-
 drivers/staging/rtlwifi/base.c                     |   13 +-
 drivers/staging/rtlwifi/base.h                     |   13 +-
 drivers/staging/rtlwifi/btcoexist/halbt_precomp.h  |   13 +-
 .../staging/rtlwifi/btcoexist/halbtc8822b1ant.c    |   13 +-
 .../staging/rtlwifi/btcoexist/halbtc8822b1ant.h    |   13 +-
 .../staging/rtlwifi/btcoexist/halbtc8822b2ant.c    |   13 +-
 .../staging/rtlwifi/btcoexist/halbtc8822b2ant.h    |   13 +-
 .../rtlwifi/btcoexist/halbtc8822bwifionly.c        |   13 +-
 .../rtlwifi/btcoexist/halbtc8822bwifionly.h        |   13 +-
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c   |   13 +-
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.h   |   13 +-
 drivers/staging/rtlwifi/btcoexist/rtl_btc.c        |   13 +-
 drivers/staging/rtlwifi/btcoexist/rtl_btc.h        |   13 +-
 drivers/staging/rtlwifi/cam.c                      |   13 +-
 drivers/staging/rtlwifi/cam.h                      |   13 +-
 drivers/staging/rtlwifi/core.c                     |   13 +-
 drivers/staging/rtlwifi/core.h                     |   13 +-
 drivers/staging/rtlwifi/debug.c                    |   32 +-
 drivers/staging/rtlwifi/debug.h                    |   13 +-
 drivers/staging/rtlwifi/efuse.c                    |   13 +-
 drivers/staging/rtlwifi/efuse.h                    |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_2_platform.h |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_8822b_cfg.h    |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_8822b_phy.c    |   13 +-
 .../halmac_8822b/halmac_8822b_pwr_seq.c            |   13 +-
 .../halmac_8822b/halmac_8822b_pwr_seq.h            |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_api_8822b.c    |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_api_8822b.h    |   13 +-
 .../halmac_8822b/halmac_api_8822b_pcie.c           |   13 +-
 .../halmac_8822b/halmac_api_8822b_pcie.h           |   13 +-
 .../halmac_8822b/halmac_api_8822b_sdio.c           |   13 +-
 .../halmac_8822b/halmac_api_8822b_sdio.h           |   13 +-
 .../halmac_8822b/halmac_api_8822b_usb.c            |   13 +-
 .../halmac_8822b/halmac_api_8822b_usb.h            |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_func_8822b.c   |   13 +-
 .../halmac_88xx/halmac_8822b/halmac_func_8822b.h   |   13 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_88xx_cfg.h   |   13 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_api_88xx.c   |   13 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_api_88xx.h   |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_pcie.c      |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_pcie.h      |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_sdio.c      |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_sdio.h      |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_usb.c       |   13 +-
 .../halmac/halmac_88xx/halmac_api_88xx_usb.h       |   13 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c  |   13 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_func_88xx.h  |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_api.c        |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_api.h        |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_bit2.h       |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_bit_8822b.h  |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_fw_info.h    |   13 +-
 .../rtlwifi/halmac/halmac_fw_offload_c2h_nic.h     |   13 +-
 .../rtlwifi/halmac/halmac_fw_offload_h2c_nic.h     |   13 +-
 .../rtlwifi/halmac/halmac_h2c_extra_info_nic.h     |   13 +-
 .../staging/rtlwifi/halmac/halmac_intf_phy_cmd.h   |   13 +-
 .../rtlwifi/halmac/halmac_original_c2h_nic.h       |   13 +-
 .../rtlwifi/halmac/halmac_original_h2c_nic.h       |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h   |   13 +-
 .../staging/rtlwifi/halmac/halmac_pwr_seq_cmd.h    |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_reg2.h       |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_reg_8822b.h  |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_rx_bd_chip.h |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_rx_bd_nic.h  |   13 +-
 .../staging/rtlwifi/halmac/halmac_rx_desc_chip.h   |   13 +-
 .../staging/rtlwifi/halmac/halmac_rx_desc_nic.h    |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_sdio_reg.h   |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_tx_bd_chip.h |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_tx_bd_nic.h  |   13 +-
 .../staging/rtlwifi/halmac/halmac_tx_desc_chip.h   |   13 +-
 .../staging/rtlwifi/halmac/halmac_tx_desc_nic.h    |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_type.h       |   13 +-
 drivers/staging/rtlwifi/halmac/halmac_usb_reg.h    |   13 +-
 drivers/staging/rtlwifi/halmac/rtl_halmac.c        |   13 +-
 drivers/staging/rtlwifi/halmac/rtl_halmac.h        |   13 +-
 drivers/staging/rtlwifi/pci.c                      |   13 +-
 drivers/staging/rtlwifi/pci.h                      |   13 +-
 drivers/staging/rtlwifi/phydm/halphyrf_ce.c        |   13 +-
 drivers/staging/rtlwifi/phydm/halphyrf_ce.h        |   13 +-
 drivers/staging/rtlwifi/phydm/mp_precomp.h         |   13 +-
 drivers/staging/rtlwifi/phydm/phydm.c              |   13 +-
 drivers/staging/rtlwifi/phydm/phydm.h              |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_acs.c          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_acs.h          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_adaptivity.c   |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_adaptivity.h   |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_adc_sampling.h |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_antdiv.c       |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_antdiv.h       |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_beamforming.h  |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_ccx.c          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_ccx.h          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_cfotracking.c  |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_cfotracking.h  |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_debug.c        |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_debug.h        |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_dfs.h          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_dig.c          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_dig.h          |   13 +-
 .../staging/rtlwifi/phydm/phydm_dynamic_rx_path.h  |   13 +-
 .../rtlwifi/phydm/phydm_dynamicbbpowersaving.c     |   13 +-
 .../rtlwifi/phydm/phydm_dynamicbbpowersaving.h     |   13 +-
 .../staging/rtlwifi/phydm/phydm_dynamictxpower.c   |   13 +-
 .../staging/rtlwifi/phydm/phydm_dynamictxpower.h   |   13 +-
 .../staging/rtlwifi/phydm/phydm_edcaturbocheck.c   |   13 +-
 .../staging/rtlwifi/phydm/phydm_edcaturbocheck.h   |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_features.h     |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_hwconfig.c     |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_hwconfig.h     |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_interface.c    |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_interface.h    |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_iqk.h          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_kfree.c        |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_kfree.h        |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_noisemonitor.c |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_noisemonitor.h |   13 +-
 .../staging/rtlwifi/phydm/phydm_powertracking_ce.c |   13 +-
 .../staging/rtlwifi/phydm/phydm_powertracking_ce.h |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_pre_define.h   |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_precomp.h      |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_psd.c          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_psd.h          |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c       |   17 +-
 drivers/staging/rtlwifi/phydm/phydm_rainfo.h       |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_reg.h          |   13 +-
 .../staging/rtlwifi/phydm/phydm_regdefine11ac.h    |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_regdefine11n.h |   13 +-
 drivers/staging/rtlwifi/phydm/phydm_types.h        |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_bb.c      |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_bb.h      |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_mac.c     |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_mac.h     |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_rf.c      |   13 +-
 .../rtlwifi/phydm/rtl8822b/halhwimg8822b_rf.h      |   13 +-
 .../rtlwifi/phydm/rtl8822b/halphyrf_8822b.c        |   47 +-
 .../rtlwifi/phydm/rtl8822b/halphyrf_8822b.h        |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_hal_api8822b.c    |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_hal_api8822b.h    |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_iqk_8822b.c       |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_iqk_8822b.h       |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_regconfig8822b.c  |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_regconfig8822b.h  |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_rtl8822b.c        |   13 +-
 .../rtlwifi/phydm/rtl8822b/phydm_rtl8822b.h        |   13 +-
 .../rtlwifi/phydm/rtl8822b/version_rtl8822b.h      |   13 +-
 drivers/staging/rtlwifi/phydm/rtl_phydm.c          |   13 +-
 drivers/staging/rtlwifi/phydm/rtl_phydm.h          |   13 +-
 drivers/staging/rtlwifi/phydm/txbf/halcomtxbf.h    |   13 +-
 drivers/staging/rtlwifi/phydm/txbf/haltxbf8822b.h  |   13 +-
 .../staging/rtlwifi/phydm/txbf/haltxbfinterface.h  |   13 +-
 drivers/staging/rtlwifi/phydm/txbf/haltxbfjaguar.h |   13 +-
 .../rtlwifi/phydm/txbf/phydm_hal_txbf_api.h        |   13 +-
 drivers/staging/rtlwifi/ps.c                       |   13 +-
 drivers/staging/rtlwifi/ps.h                       |   13 +-
 drivers/staging/rtlwifi/pwrseqcmd.h                |   13 +-
 drivers/staging/rtlwifi/rc.c                       |   13 +-
 drivers/staging/rtlwifi/rc.h                       |   13 +-
 drivers/staging/rtlwifi/regd.c                     |   13 +-
 drivers/staging/rtlwifi/regd.h                     |   13 +-
 drivers/staging/rtlwifi/rtl8822be/def.h            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/fw.c             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/fw.h             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/hw.h             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/led.c            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/led.h            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/phy.c            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/phy.h            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/reg.h            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/sw.c             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/sw.h             |   13 +-
 drivers/staging/rtlwifi/rtl8822be/trx.c            |   13 +-
 drivers/staging/rtlwifi/rtl8822be/trx.h            |   13 +-
 drivers/staging/rtlwifi/stats.c                    |   13 +-
 drivers/staging/rtlwifi/stats.h                    |   13 +-
 drivers/staging/rtlwifi/wifi.h                     |   13 +-
 drivers/staging/sm750fb/TODO                       |    5 +-
 drivers/staging/speakup/buffers.c                  |    4 +
 drivers/staging/speakup/main.c                     |    6 +
 drivers/staging/speakup/speakup.h                  |    3 +-
 drivers/staging/speakup/speakup_dummy.c            |    1 +
 drivers/staging/speakup/speakup_soft.c             |    3 +-
 drivers/staging/speakup/spk_types.h                |    2 +-
 drivers/staging/speakup/varhandlers.c              |    1 +
 drivers/staging/unisys/visornic/visornic_main.c    |   25 +-
 drivers/staging/vboxvideo/vbox_main.c              |    3 +-
 drivers/staging/vboxvideo/vbox_mode.c              |    2 +-
 drivers/staging/vc04_services/Kconfig              |    1 -
 drivers/staging/vc04_services/Makefile             |    2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |   64 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   43 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |   12 +
 drivers/staging/vc04_services/bcm2835-camera/TODO  |   11 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |  402 +-
 .../vc04_services/bcm2835-camera/mmal-common.h     |    9 +-
 .../vc04_services/bcm2835-camera/mmal-msg-port.h   |    2 +-
 .../vc04_services/bcm2835-camera/mmal-parameters.h |   13 +
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  345 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.h      |   15 +-
 drivers/staging/vc04_services/interface/vchi/TODO  |    9 +-
 .../vc04_services/interface/vchi/vchi_common.h     |    2 -
 .../interface/vchiq_arm/vchiq_2835_arm.c           |    6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   96 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |   55 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |    1 -
 .../interface/vchiq_arm/vchiq_debugfs.c            |  137 +-
 .../interface/vchiq_arm/vchiq_debugfs.h            |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |    1 -
 drivers/staging/vt6655/card.c                      |    5 +-
 drivers/staging/vt6655/device_main.c               |  150 +-
 drivers/staging/wilc1000/TODO                      |   12 +-
 drivers/staging/wilc1000/coreconfigurator.c        |  140 +-
 drivers/staging/wilc1000/coreconfigurator.h        |   37 +-
 drivers/staging/wilc1000/host_interface.c          |  549 ++-
 drivers/staging/wilc1000/host_interface.h          |    6 +-
 drivers/staging/wilc1000/linux_mon.c               |   90 +-
 drivers/staging/wilc1000/linux_wlan.c              |  378 +-
 drivers/staging/wilc1000/wilc_debugfs.c            |    2 -
 drivers/staging/wilc1000/wilc_sdio.c               |  109 +-
 drivers/staging/wilc1000/wilc_spi.c                |   99 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  | 1049 +++--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.h  |   18 +-
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   83 +-
 drivers/staging/wilc1000/wilc_wlan.c               |   26 +-
 drivers/staging/wilc1000/wilc_wlan.h               |   37 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |    1 -
 drivers/staging/wilc1000/wilc_wlan_if.h            |   16 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |    7 +-
 drivers/staging/wlan-ng/p80211conv.c               |    8 +-
 drivers/staging/wlan-ng/p80211conv.h               |   26 +-
 drivers/staging/wlan-ng/p80211hdr.h                |    2 +-
 drivers/staging/wlan-ng/p80211ioctl.h              |    2 +-
 drivers/staging/wlan-ng/p80211metadef.h            |    2 +-
 drivers/staging/wlan-ng/p80211metastruct.h         |   90 +-
 drivers/staging/wlan-ng/p80211mgmt.h               |    2 +-
 drivers/staging/wlan-ng/p80211msg.h                |    2 +-
 drivers/staging/wlan-ng/p80211netdev.c             |    8 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    8 +-
 drivers/staging/wlan-ng/p80211req.h                |    2 +-
 drivers/staging/wlan-ng/p80211types.h              |   33 +-
 drivers/staging/wlan-ng/prism2mgmt.h               |    2 +-
 drivers/staging/wlan-ng/prism2sta.c                |   52 +-
 fs/compat.c                                        |   72 +-
 include/linux/iio/adc/ad_sigma_delta.h             |   24 +-
 include/linux/iio/adc/stm32-dfsdm-adc.h            |    2 +
 .../linux/iio/common}/cros_ec_sensors_core.h       |    3 +
 include/linux/iio/iio.h                            |   24 +-
 include/linux/kernel.h                             |   16 +
 include/linux/platform_data/tsl2772.h              |  101 +
 include/uapi/linux/ncp.h                           |  202 -
 include/uapi/linux/ncp_fs.h                        |  147 -
 include/uapi/linux/ncp_mount.h                     |   72 -
 include/uapi/linux/ncp_no.h                        |   20 -
 scripts/selinux/mdp/mdp.c                          |    1 -
 tools/iio/iio_generic_buffer.c                     |   13 +-
 1007 files changed, 16828 insertions(+), 227770 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
 delete mode 100644 Documentation/filesystems/ncpfs.txt
 create mode 100644 drivers/iio/accel/adis16201.c
 rename drivers/{staging => }/iio/accel/adis16209.c (92%)
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-rescale.c
 create mode 100644 drivers/iio/dac/ad5686-spi.c
 create mode 100644 drivers/iio/dac/ad5686.h
 create mode 100644 drivers/iio/dac/ad5696-i2c.c
 create mode 100644 drivers/iio/dac/ti-dac5571.c
 create mode 100644 drivers/iio/light/tsl2772.c
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 rename drivers/{staging => }/iio/resolver/ad2s1200.c (52%)
 create mode 100644 drivers/staging/android/uapi/vsoc_shm.h
 create mode 100644 drivers/staging/android/vsoc.c
 create mode 100644 drivers/staging/fbtft/TODO
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/dprtc.c
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/dprtc.h
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/rtc.c
 create mode 100644 drivers/staging/fsl-dpaa2/rtc/rtc.h
 delete mode 100644 drivers/staging/goldfish/goldfish_nand.c
 delete mode 100644 drivers/staging/goldfish/goldfish_nand_reg.h
 create mode 100644 drivers/staging/greybus/TODO
 delete mode 100644 drivers/staging/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 delete mode 100644 drivers/staging/iio/light/tsl2x7x.c
 delete mode 100644 drivers/staging/iio/light/tsl2x7x.h
 delete mode 100644 drivers/staging/iio/meter/ade7753.c
 delete mode 100644 drivers/staging/iio/meter/ade7754.c
 delete mode 100644 drivers/staging/iio/meter/ade7758.h
 delete mode 100644 drivers/staging/iio/meter/ade7758_core.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_ring.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_trigger.c
 delete mode 100644 drivers/staging/iio/meter/ade7759.c
 delete mode 100644 drivers/staging/ipx/Kconfig
 delete mode 100644 drivers/staging/ipx/Makefile
 delete mode 100644 drivers/staging/ipx/TODO
 delete mode 100644 drivers/staging/ipx/af_ipx.c
 delete mode 100644 drivers/staging/ipx/ipx_proc.c
 delete mode 100644 drivers/staging/ipx/ipx_route.c
 delete mode 100644 drivers/staging/ipx/pe2.c
 delete mode 100644 drivers/staging/ipx/sysctl_net_ipx.c
 delete mode 100644 drivers/staging/ks7010/ks7010_sdio.h
 delete mode 100644 drivers/staging/lustre/Kconfig
 delete mode 100644 drivers/staging/lustre/Makefile
 delete mode 100644 drivers/staging/lustre/README.txt
 delete mode 100644 drivers/staging/lustre/TODO
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/curproc.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_crypto.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_fail.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_hash.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_prim.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_private.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_string.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
 delete mode 100644 drivers/staging/lustre/include/linux/lnet/api.h
 delete mode 100644 drivers/staging/lustre/include/linux/lnet/lib-lnet.h
 delete mode 100644 drivers/staging/lustre/include/linux/lnet/lib-types.h
 delete mode 100644 drivers/staging/lustre/include/linux/lnet/socklnd.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/libcfs_debug.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/libcfs_ioctl.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/lnet-types.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/lnetst.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lnet/socklnd.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_kernelcomm.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_ostid.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_param.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
 delete mode 100644 drivers/staging/lustre/include/uapi/linux/lustre/lustre_ver.h
 delete mode 100644 drivers/staging/lustre/lnet/Kconfig
 delete mode 100644 drivers/staging/lustre/lnet/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/klnds/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
 delete mode 100644 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.h
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd_lib.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd_modparams.c
 delete mode 100644 drivers/staging/lustre/lnet/klnds/socklnd/socklnd_proto.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/debug.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/fail.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/hash.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/libcfs_lock.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/libcfs_mem.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/libcfs_string.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto.h
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-tracefile.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/module.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/tracefile.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/tracefile.h
 delete mode 100644 drivers/staging/lustre/lnet/lnet/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/lnet/acceptor.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/api-ni.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/config.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-eq.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-md.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-me.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-move.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-msg.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-ptl.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lib-socket.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/lo.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/module.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/net_fault.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/nidstrings.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/peer.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/router.c
 delete mode 100644 drivers/staging/lustre/lnet/lnet/router_proc.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/Makefile
 delete mode 100644 drivers/staging/lustre/lnet/selftest/brw_test.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/conctl.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/conrpc.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/conrpc.h
 delete mode 100644 drivers/staging/lustre/lnet/selftest/console.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/console.h
 delete mode 100644 drivers/staging/lustre/lnet/selftest/framework.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/module.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/ping_test.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/rpc.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/rpc.h
 delete mode 100644 drivers/staging/lustre/lnet/selftest/selftest.h
 delete mode 100644 drivers/staging/lustre/lnet/selftest/timer.c
 delete mode 100644 drivers/staging/lustre/lnet/selftest/timer.h
 delete mode 100644 drivers/staging/lustre/lustre/Kconfig
 delete mode 100644 drivers/staging/lustre/lustre/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/fid/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/fid/fid_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/fid/fid_lib.c
 delete mode 100644 drivers/staging/lustre/lustre/fid/fid_request.c
 delete mode 100644 drivers/staging/lustre/lustre/fid/lproc_fid.c
 delete mode 100644 drivers/staging/lustre/lustre/fld/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/fld/fld_cache.c
 delete mode 100644 drivers/staging/lustre/lustre/fld/fld_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/fld/fld_request.c
 delete mode 100644 drivers/staging/lustre/lustre/fld/lproc_fld.c
 delete mode 100644 drivers/staging/lustre/lustre/include/cl_object.h
 delete mode 100644 drivers/staging/lustre/lustre/include/interval_tree.h
 delete mode 100644 drivers/staging/lustre/lustre/include/llog_swab.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lprocfs_status.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lu_object.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lu_ref.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_acl.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_compat.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_debug.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_disk.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_dlm.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_dlm_flags.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_errno.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_export.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_fid.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_fld.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_ha.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_handles.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_import.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_intent.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_kernelcomm.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_lib.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_linkea.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_lmv.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_log.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_mdc.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_mds.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_net.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_nrs.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_nrs_fifo.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_obdo.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_patchless_compat.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_req_layout.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_sec.h
 delete mode 100644 drivers/staging/lustre/lustre/include/lustre_swab.h
 delete mode 100644 drivers/staging/lustre/lustre/include/obd.h
 delete mode 100644 drivers/staging/lustre/lustre/include/obd_cksum.h
 delete mode 100644 drivers/staging/lustre/lustre/include/obd_class.h
 delete mode 100644 drivers/staging/lustre/lustre/include/obd_support.h
 delete mode 100644 drivers/staging/lustre/lustre/include/seq_range.h
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/interval_tree.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/l_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_extent.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_flock.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_inodebits.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_lib.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_plain.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_request.c
 delete mode 100644 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/llite/dcache.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/dir.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/file.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/glimpse.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/lcommon_cl.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/lcommon_misc.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/llite_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/llite/llite_lib.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/llite_mmap.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/llite_nfs.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/lproc_llite.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/namei.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/range_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/range_lock.h
 delete mode 100644 drivers/staging/lustre/lustre/llite/rw.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/rw26.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/statahead.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/super25.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/symlink.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_dev.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_io.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_object.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/vvp_page.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/xattr.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/xattr_cache.c
 delete mode 100644 drivers/staging/lustre/lustre/llite/xattr_security.c
 delete mode 100644 drivers/staging/lustre/lustre/lmv/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/lmv/lmv_fld.c
 delete mode 100644 drivers/staging/lustre/lustre/lmv/lmv_intent.c
 delete mode 100644 drivers/staging/lustre/lustre/lmv/lmv_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/lmv/lmv_obd.c
 delete mode 100644 drivers/staging/lustre/lustre/lmv/lproc_lmv.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_cl_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_dev.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_ea.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_io.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_merge.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_obd.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_object.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_offset.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_pack.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_page.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_pool.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lov_request.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lovsub_dev.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lovsub_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lovsub_object.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lovsub_page.c
 delete mode 100644 drivers/staging/lustre/lustre/lov/lproc_lov.c
 delete mode 100644 drivers/staging/lustre/lustre/mdc/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/mdc/lproc_mdc.c
 delete mode 100644 drivers/staging/lustre/lustre/mdc/mdc_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/mdc/mdc_lib.c
 delete mode 100644 drivers/staging/lustre/lustre/mdc/mdc_locks.c
 delete mode 100644 drivers/staging/lustre/lustre/mdc/mdc_reint.c
 delete mode 100644 drivers/staging/lustre/lustre/mdc/mdc_request.c
 delete mode 100644 drivers/staging/lustre/lustre/mgc/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/mgc/lproc_mgc.c
 delete mode 100644 drivers/staging/lustre/lustre/mgc/mgc_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/mgc/mgc_request.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/cl_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/cl_io.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/cl_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/cl_object.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/cl_page.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/class_obd.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/debug.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/genops.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/kernelcomm.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/linkea.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/linux/linux-sysctl.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/llog.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/llog_cat.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/llog_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/llog_obd.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/llog_swab.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lprocfs_counters.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lprocfs_status.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lu_object.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lu_ref.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lustre_handles.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/lustre_peer.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/obd_config.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/obd_mount.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/obdo.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/statfs_pack.c
 delete mode 100644 drivers/staging/lustre/lustre/obdclass/uuid.c
 delete mode 100644 drivers/staging/lustre/lustre/obdecho/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/obdecho/echo_client.c
 delete mode 100644 drivers/staging/lustre/lustre/obdecho/echo_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/osc/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/osc/lproc_osc.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_cache.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_cl_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_dev.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_io.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_lock.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_object.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_page.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_quota.c
 delete mode 100644 drivers/staging/lustre/lustre/osc/osc_request.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/Makefile
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/client.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/connection.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/errno.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/events.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/import.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/layout.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/llog_client.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/llog_net.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/lproc_ptlrpc.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/niobuf.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/nrs.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/nrs_fifo.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/pack_generic.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/pers.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/pinger.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/ptlrpc_internal.h
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/ptlrpc_module.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/recover.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_config.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_lproc.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_null.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/sec_plain.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/service.c
 delete mode 100644 drivers/staging/lustre/lustre/ptlrpc/wiretest.c
 delete mode 100644 drivers/staging/lustre/sysfs-fs-lustre
 delete mode 100644 drivers/staging/most/dim2/dim2.h
 create mode 100644 drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt
 delete mode 100644 drivers/staging/ncpfs/Kconfig
 delete mode 100644 drivers/staging/ncpfs/Makefile
 delete mode 100644 drivers/staging/ncpfs/TODO
 delete mode 100644 drivers/staging/ncpfs/dir.c
 delete mode 100644 drivers/staging/ncpfs/file.c
 delete mode 100644 drivers/staging/ncpfs/getopt.c
 delete mode 100644 drivers/staging/ncpfs/getopt.h
 delete mode 100644 drivers/staging/ncpfs/inode.c
 delete mode 100644 drivers/staging/ncpfs/ioctl.c
 delete mode 100644 drivers/staging/ncpfs/mmap.c
 delete mode 100644 drivers/staging/ncpfs/ncp_fs.h
 delete mode 100644 drivers/staging/ncpfs/ncp_fs_i.h
 delete mode 100644 drivers/staging/ncpfs/ncp_fs_sb.h
 delete mode 100644 drivers/staging/ncpfs/ncplib_kernel.c
 delete mode 100644 drivers/staging/ncpfs/ncplib_kernel.h
 delete mode 100644 drivers/staging/ncpfs/ncpsign_kernel.c
 delete mode 100644 drivers/staging/ncpfs/ncpsign_kernel.h
 delete mode 100644 drivers/staging/ncpfs/sock.c
 delete mode 100644 drivers/staging/ncpfs/symlink.c
 rename drivers/staging/rtl8723bs/hal/{Hal8723BPwrSeq.c => hal_pwr_seq.c} (86%)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPhyCfg.h => hal_phy_cfg.h} (84%)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPhyReg.h => hal_phy_reg_8723b.h} (79%)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPwrSeq.h => hal_pwr_seq.h} (100%)
 rename {drivers/iio/common/cros_ec_sensors => include/linux/iio/common}/cros_ec_sensors_core.h (98%)
 create mode 100644 include/linux/platform_data/tsl2772.h
 delete mode 100644 include/uapi/linux/ncp.h
 delete mode 100644 include/uapi/linux/ncp_fs.h
 delete mode 100644 include/uapi/linux/ncp_mount.h
 delete mode 100644 include/uapi/linux/ncp_no.h
