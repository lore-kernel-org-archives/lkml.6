Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeDSFP6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:15:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeDSFPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:15:52 -0400
Date: Thu, 19 Apr 2018 08:15:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Smatch check for Spectre stuff
Message-ID: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several people have asked me to write this and I think one person was
maybe working on writing it themselves...

The point of this check is to find place which might be vulnerable to
the Spectre vulnerability.  In the kernel we have the array_index_nospec()
macro which turns off speculation.  There are fewer than 10 places where
it's used.  Meanwhile this check complains about 800 places where maybe
it could be used.  Probably the 100x difference means there is something
that I haven't understood...

What the test does is it looks at array accesses where the user controls
the offset.  It asks "is this a read?" and have we used the
array_index_nospec() macro?  If the answers are yes, and no respectively
then print a warning.

http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c

The other thing is that speculation probably goes to 200 instructions
ahead at most.  But the Smatch doesn't have any concept of CPU
instructions.  I've marked the offsets which were recently compared to
something as "local cap" because they were probably compared to the
array limit.  Those are maybe more likely to be under the 200 CPU
instruction count.

This obviously a first draft.

What would help me, is maybe people could tell me why there are so many
false positives.  Saying "the lower level checks for that" is not
helpful but if you could tell me the exact function name where the check
is that helps a lot...

I have included the warnings from yesterday's linux-next.

regards,
dan carpenter

arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids[cache_type]' (local cap)
arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids' (local cap)
arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs[cache_type]' (local cap)
arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs' (local cap)
arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)
arch/x86/events/msr.c:178 msr_event_init() warn: potential spectre issue 'msr' (local cap)
./arch/x86/include/asm/xen/page.h:120 __pfn_to_mfn() warn: potential spectre issue 'xen_p2m_addr' (local cap)
arch/x86/kvm/lapic.c:136 kvm_apic_map_get_logical_dest() warn: potential spectre issue 'map->phys_map' (local cap)
arch/x86/kvm/lapic.c:841 kvm_apic_map_get_dest_lapic() warn: potential spectre issue 'map->phys_map' (local cap)
crypto/anubis.c:557 anubis_setkey() warn: potential spectre issue 'ctx->E' (local cap)
drivers/acpi/acpica/dbmethod.c:181 acpi_db_set_method_data() warn: potential spectre issue 'walk_state->arguments' (local cap)
drivers/acpi/acpica/dsmthdat.c:249 acpi_ds_method_data_get_node() warn: potential spectre issue 'walk_state->arguments' (local cap)
drivers/acpi/acpica/hwxface.c:360 acpi_get_sleep_type_data() warn: potential spectre issue 'acpi_gbl_sleep_state_names' (local cap)
drivers/acpi/acpica/utdecode.c:467 acpi_ut_get_notify_name() warn: potential spectre issue 'acpi_gbl_generic_notify' (local cap)
drivers/acpi/fan.c:203 fan_set_state_acpi4() warn: potential spectre issue 'fan->fps' (local cap)
drivers/ata/libata-scsi.c:3040 ata_find_dev() warn: potential spectre issue 'ap->pmp_link' (local cap)
drivers/atm/lanai.c:2503 lanai_proc_read() warn: potential spectre issue 'lanai->vccs' (local cap)
drivers/block/DAC960.c:6638 DAC960_gam_get_controller_info() warn: potential spectre issue 'DAC960_Controllers' (local cap)
drivers/block/DAC960.c:6689 DAC960_gam_v1_execute_command() warn: potential spectre issue 'DAC960_Controllers' (local cap)
drivers/block/DAC960.c:6856 DAC960_gam_v2_execute_command() warn: potential spectre issue 'DAC960_Controllers' (local cap)
drivers/block/DAC960.c:7014 DAC960_gam_v2_get_health_status() warn: potential spectre issue 'DAC960_Controllers' (local cap)
drivers/block/loop.c:1110 loop_set_status() warn: potential spectre issue 'xfer_funcs' (local cap)
drivers/bluetooth/hci_ldisc.c:90 hci_uart_get_proto() warn: potential spectre issue 'hup' (local cap)
drivers/cdrom/cdrom.c:2383 cdrom_ioctl_media_changed() warn: potential spectre issue 'info->slots' (local cap)
drivers/char/applicom.c:837 ac_ioctl() warn: potential spectre issue 'apbs' (local cap)
drivers/char/raw.c:139 bind_set() warn: potential spectre issue 'raw_devices' (local cap)
drivers/char/raw.c:195 bind_get() warn: potential spectre issue 'raw_devices' (local cap)
drivers/crypto/qat/qat_common/adf_transport.c:271 adf_create_ring() warn: potential spectre issue 'transport_data->banks' (local cap)
drivers/gpio/gpiolib.c:1029 gpio_ioctl() warn: potential spectre issue 'gdev->descs' (local cap)
drivers/gpio/gpiolib.c:902 lineevent_create() warn: potential spectre issue 'gdev->descs' (local cap)
drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:1573 kfd_ioctl() warn: potential spectre issue 'amdkfd_ioctls' (local cap)
drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential spectre issue 'dma->buflist' (local cap)
drivers/gpu/drm/drm_fb_helper.c:1366 setcmap_new_gamma_lut() warn: potential spectre issue 'r' (local cap)
drivers/gpu/drm/drm_fb_helper.c:1367 setcmap_new_gamma_lut() warn: potential spectre issue 'g' (local cap)
drivers/gpu/drm/drm_fb_helper.c:1368 setcmap_new_gamma_lut() warn: potential spectre issue 'b' (local cap)
drivers/gpu/drm/drm_ioctl.c:794 drm_ioctl() warn: potential spectre issue 'drm_ioctls' (local cap)
drivers/gpu/drm/drm_ioctl.c:876 drm_ioctl_flags() warn: potential spectre issue 'drm_ioctls' (local cap)
drivers/gpu/drm/gma500/gtt.c:185 psb_gtt_roll() warn: potential spectre issue 'r->pages' (local cap)
drivers/gpu/drm/i915/gvt/handlers.c:873 dp_aux_ch_ctl_mmio_write() warn: potential spectre issue 'display->ports' (local cap)
drivers/hid/usbhid/hiddev.c:473 hiddev_ioctl_usage() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:477 hiddev_ioctl_usage() warn: potential spectre issue 'field->usage' (local cap)
drivers/hid/usbhid/hiddev.c:757 hiddev_ioctl() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:801 hiddev_ioctl() warn: potential spectre issue 'hid->collection' (local cap)
drivers/hwmon/pwm-fan.c:150 pwm_fan_set_cur_state() warn: potential spectre issue 'ctx->pwm_fan_cooling_levels' (local cap)
drivers/infiniband/core/cache.c:944 ib_get_cached_pkey() warn: potential spectre issue 'cache->table' (local cap)
drivers/infiniband/core/rdma_core.c:65 uverbs_get_object() warn: potential spectre issue 'object_hash->object_buckets' (local cap)
drivers/infiniband/core/rdma_core.c:70 uverbs_get_object() warn: potential spectre issue 'objects->objects' (local cap)
drivers/infiniband/core/rdma_core.c:82 uverbs_get_method() warn: potential spectre issue 'object->method_buckets' (local cap)
drivers/infiniband/core/rdma_core.c:86 uverbs_get_method() warn: potential spectre issue 'methods->methods' (local cap)
drivers/infiniband/core/uverbs_main.c:768 ib_uverbs_write() warn: potential spectre issue 'uverbs_cmd_table' (local cap)
drivers/infiniband/core/verbs.c:1280 ib_modify_qp_is_ok() warn: potential spectre issue 'qp_state_table' (local cap)
drivers/infiniband/hw/i40iw/i40iw_utils.c:676 i40iw_get_qp() warn: potential spectre issue 'iwdev->qp_table' (local cap)
drivers/input/input.c:234 input_handle_abs_event() warn: potential spectre issue 'dev->absinfo' (local cap)
drivers/input/input.c:835 input_default_setkeycode() warn: potential spectre issue 'k' (local cap)
drivers/input/input.c:841 input_default_setkeycode() warn: potential spectre issue 'k' (local cap)
drivers/input/input.c:847 input_default_setkeycode() warn: potential spectre issue 'k' (local cap)
drivers/input/rmi4/rmi_f54.c:155 rmi_f54_get_reptype() warn: potential spectre issue 'f54->inputs' (local cap)
drivers/md/raid1.c:3011 setup_conf() warn: potential spectre issue 'disk' (local cap)
drivers/media/common/videobuf2/videobuf2-core.c:1858 vb2_core_expbuf() warn: potential spectre issue 'q->bufs' (local cap)
drivers/media/common/videobuf2/videobuf2-v4l2.c:181 vb2_queue_or_prepare_buf() warn: potential spectre issue 'q->bufs' (local cap)
drivers/media/common/videobuf2/videobuf2-v4l2.c:478 vb2_querybuf() warn: potential spectre issue 'q->bufs' (local cap)
drivers/media/dvb-core/dvb_ca_en50221.c:1400 dvb_ca_en50221_io_do_ioctl() warn: potential spectre issue 'ca->slot_info' (local cap)
drivers/media/dvb-core/dvb_ca_en50221.c:1479 dvb_ca_en50221_io_write() warn: potential spectre issue 'ca->slot_info' (local cap)
drivers/media/dvb-core/dvb_net.c:1483 dvb_net_do_ioctl() warn: potential spectre issue 'dvbnet->device' (local cap)
drivers/media/dvb-frontends/mt312.c:444 mt312_set_voltage() warn: potential spectre issue 'volt_tab' (local cap)
drivers/media/dvb-frontends/rtl2832_sdr.c:1137 rtl2832_sdr_enum_fmt_sdr_cap() warn: potential spectre issue 'formats' (local cap)
drivers/media/i2c/adv7604.c:1814 adv76xx_enum_mbus_code() warn: potential spectre issue 'state->info->formats' (local cap)
drivers/media/i2c/adv7604.c:613 adv76xx_read_reg() warn: potential spectre issue 'state->regmap' (local cap)
drivers/media/i2c/adv7604.c:629 adv76xx_write_reg() warn: potential spectre issue 'state->regmap' (local cap)
drivers/media/i2c/mt9t112.c:1006 mt9t112_enum_mbus_code() warn: potential spectre issue 'mt9t112_cfmts' (local cap)
drivers/media/i2c/ov5640.c:2318 ov5640_enum_frame_size() warn: potential spectre issue 'ov5640_mode_data[0]' (local cap)
drivers/media/i2c/soc_camera/mt9m001.c:595 mt9m001_enum_mbus_code() warn: potential spectre issue 'mt9m001->fmts' (local cap)
drivers/media/i2c/soc_camera/mt9t112.c:1001 mt9t112_enum_mbus_code() warn: potential spectre issue 'mt9t112_cfmts' (local cap)
drivers/media/i2c/soc_camera/mt9v022.c:791 mt9v022_enum_mbus_code() warn: potential spectre issue 'mt9v022->fmts' (local cap)
drivers/media/pci/zoran/zoran_driver.c:1351 zoran_v4l2_buffer_status() warn: potential spectre issue 'fh->buffers.buffer' (local cap)
drivers/media/pci/zoran/zoran_driver.c:1497 zoran_set_input() warn: potential spectre issue 'zr->card.input' (local cap)
drivers/media/pci/zoran/zoran_driver.c:546 zoran_v4l_queue_frame() warn: potential spectre issue 'zr->v4l_buffers.buffer' (local cap)
drivers/media/pci/zoran/zoran_driver.c:703 zoran_jpg_queue_frame() warn: potential spectre issue 'zr->jpg_buffers.buffer' (local cap)
drivers/media/platform/atmel/atmel-isc.c:1258 isc_enum_fmt_vid_cap() warn: potential spectre issue 'isc->user_formats' (local cap)
drivers/media/platform/atmel/atmel-isi.c:651 isi_enum_fmt_vid_cap() warn: potential spectre issue 'isi->user_formats' (local cap)
drivers/media/platform/davinci/vpif_display.c:763 vpif_enum_output() warn: potential spectre issue 'chan_cfg->outputs' (local cap)
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:529 mtk_jpeg_qbuf() warn: potential spectre issue 'vq->bufs' (local cap)
drivers/media/platform/pxa_camera.c:1858 pxac_vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'pcdev->user_formats' (local cap)
drivers/media/platform/renesas-ceu.c:1125 ceu_enum_input() warn: potential spectre issue 'ceudev->subdevs' (local cap)
drivers/media/platform/renesas-ceu.c:1160 ceu_s_input() warn: potential spectre issue 'ceudev->subdevs' (local cap)
drivers/media/platform/soc_camera/soc_camera.c:873 soc_camera_enum_fmt_vid_cap() warn: potential spectre issue 'icd->user_formats' (local cap)
drivers/media/platform/sti/delta/delta-v4l2.c:421 delta_enum_fmt_stream() warn: potential spectre issue 'delta->streamformats' (local cap)
drivers/media/platform/sti/delta/delta-v4l2.c:435 delta_enum_fmt_frame() warn: potential spectre issue 'delta->pixelformats' (local cap)
drivers/media/platform/sti/hva/hva-v4l2.c:276 hva_enum_fmt_stream() warn: potential spectre issue 'hva->streamformats' (local cap)
drivers/media/platform/sti/hva/hva-v4l2.c:290 hva_enum_fmt_frame() warn: potential spectre issue 'hva->pixelformats' (local cap)
drivers/media/platform/sti/hva/hva-v4l2.c:577 hva_qbuf() warn: potential spectre issue 'vq->bufs' (local cap)
drivers/media/platform/stm32/stm32-dcmi.c:992 dcmi_enum_fmt_vid_cap() warn: potential spectre issue 'dcmi->sd_formats' (local cap)
drivers/media/platform/ti-vpe/cal.c:935 cal_enum_fmt_vid_cap() warn: potential spectre issue 'ctx->active_fmt' (local cap)
drivers/media/platform/vivid/vivid-radio-rx.c:144 vivid_radio_rx_enum_freq_bands() warn: potential spectre issue 'vivid_radio_bands' (local cap)
drivers/media/platform/vivid/vivid-vid-cap.c:1391 vidioc_s_input() warn: potential spectre issue 'dev->input_brightness' (local cap)
drivers/media/platform/vsp1/vsp1_entity.c:229 vsp1_subdev_enum_mbus_code() warn: potential spectre issue 'codes' (local cap)
drivers/media/rc/rc-main.c:528 ir_getkeycode() warn: potential spectre issue 'rc_map->scan' (local cap)
drivers/media/usb/cpia2/cpia2_v4l.c:814 cpia2_querybuf() warn: potential spectre issue 'cam->buffers' (local cap)
drivers/media/usb/dvb-usb/dvb-usb-remote.c:57 legacy_dvb_usb_getkeycode() warn: potential spectre issue 'keymap' (local cap)
drivers/media/usb/dvb-usb/dvb-usb-remote.c:87 legacy_dvb_usb_setkeycode() warn: potential spectre issue 'keymap' (local cap)
drivers/media/usb/gspca/gspca.c:1460 vidioc_querybuf() warn: potential spectre issue 'gspca_dev->frame' (local cap)
drivers/media/usb/msi2500/msi2500.c:920 msi2500_enum_fmt_sdr_cap() warn: potential spectre issue 'formats' (local cap)
drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:195 pvr2_enum_input() warn: potential spectre issue 'fh->input_map' (local cap)
drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:259 pvr2_s_input() warn: potential spectre issue 'fh->input_map' (local cap)
drivers/media/usb/usbvision/usbvision-video.c:692 vidioc_querybuf() warn: potential spectre issue 'usbvision->frame' (local cap)
drivers/media/usb/usbvision/usbvision-video.c:723 vidioc_qbuf() warn: potential spectre issue 'usbvision->frame' (local cap)
drivers/media/usb/uvc/uvc_ctrl.c:1165 uvc_query_v4l2_menu() warn: potential spectre issue 'mapping->menu_info' (local cap)
drivers/media/usb/uvc/uvc_ctrl.c:1527 uvc_ctrl_set() warn: potential spectre issue 'mapping->menu_info' (local cap)
drivers/media/usb/uvc/uvc_v4l2.c:848 uvc_ioctl_enum_input() warn: potential spectre issue 'selector->baSourceID' (local cap)
drivers/media/v4l2-core/v4l2-ctrls.c:2797 v4l2_querymenu() warn: potential spectre issue 'ctrl->qmenu_int' (local cap)
drivers/message/fusion/mptctl.c:2788 mptctl_hp_targetinfo() warn: potential spectre issue 'hd->sel_timeout' (local cap)
drivers/misc/mic/scif/scif_api.c:614 __scif_connect() warn: potential spectre issue 'scif_dev' (local cap)
drivers/mtd/chips/cfi_cmdset_0001.c:1509 cfi_intelext_read() warn: potential spectre issue 'cfi->chips' (local cap)
drivers/mtd/chips/cfi_cmdset_0002.c:1162 cfi_amdstd_read() warn: potential spectre issue 'cfi->chips' (local cap)
drivers/mtd/chips/cfi_cmdset_0002.c:1273 cfi_amdstd_secsi_read() warn: potential spectre issue 'cfi->chips' (local cap)
drivers/mtd/chips/cfi_cmdset_0020.c:405 cfi_staa_read() warn: potential spectre issue 'cfi->chips' (local cap)
drivers/mtd/mtdchar.c:672 mtdchar_ioctl() warn: potential spectre issue 'mtd->eraseregions' (local cap)
drivers/mtd/parsers/sharpslpart.c:246 sharpsl_nand_read_laddr() warn: potential spectre issue 'ftl->log2phy' (local cap)
drivers/mtd/ubi/kapi.c:166 ubi_open_volume() warn: potential spectre issue 'ubi->volumes' (local cap)
drivers/net/can/dev.c:68 can_len2dlc() warn: potential spectre issue 'len2dlc' (local cap)
drivers/net/ethernet/broadcom/bnxt/bnxt.c:6205 bnxt_init_napi() warn: potential spectre issue 'bp->bnapi' (local cap)
drivers/net/ethernet/broadcom/cnic.c:397 cnic_iscsi_nl_msg_recv() warn: potential spectre issue 'cp->csk_tbl' (local cap)
drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h:145 lookup_atid() warn: potential spectre issue 't->atid_tab' (local cap)
drivers/net/ethernet/chelsio/cxgb/sge.c:1375 sge_rx() warn: potential spectre issue 'adapter->port' (local cap)
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:545 i40e_dbg_dump_desc() warn: potential spectre issue 'vsi->rx_rings' (local cap)
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:576 i40e_dbg_dump_desc() warn: potential spectre issue '(ring->desc)' (local cap)
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:688 i40e_dbg_dump_vf() warn: potential spectre issue 'pf->vf' (local cap)
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4004 i40e_add_fdir_ethtool() warn: potential spectre issue 'pf->vf' (local cap)
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:2738 ixgbe_add_ethtool_fdir_entry() warn: potential spectre issue 'adapter->rx_ring' (local cap)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9206 ixgbe_configure_clsu32() warn: potential spectre issue 'adapter->jump_tables' (local cap)
drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c:317 add_ethtool_flow_rule() warn: potential spectre issue 'priv->direct_tir' (local cap)
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:236 mlxsw_thermal_get_trip_type() warn: potential spectre issue 'thermal->trips' (local cap)
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:248 mlxsw_thermal_get_trip_temp() warn: potential spectre issue 'thermal->trips' (local cap)
drivers/net/ethernet/sfc/farch.c:2609 efx_farch_filter_remove_safe() warn: potential spectre issue 'table->spec' (local cap)
drivers/net/ethernet/sfc/farch.c:2638 efx_farch_filter_get_safe() warn: potential spectre issue 'table->spec' (local cap)
drivers/net/wireless/ath/ath10k/htc.c:414 ath10k_htc_rx_completion_handler() warn: potential spectre issue 'htc->endpoint' (local cap)
drivers/net/wireless/ath/ath10k/htt_rx.c:2691 ath10k_htt_t2h_msg_handler() warn: potential spectre issue 'ar->htt.t2h_msg_types' (local cap)
drivers/net/wireless/ath/ath6kl/htc_pipe.c:991 ath6kl_htc_pipe_rx_complete() warn: potential spectre issue 'target->endpoint' (local cap)
drivers/net/wireless/ath/ath6kl/wmi.c:1220 ath6kl_wmi_bitrate_reply_rx() warn: potential spectre issue 'wmi_rate_tbl' (local cap)
drivers/net/wireless/ath/ath9k/htc_hst.c:454 ath9k_htc_rx_msg() warn: potential spectre issue 'htc_handle->endpoint' (local cap)
drivers/net/wireless/ath/wil6210/debugfs.c:728 wil_write_back() warn: potential spectre issue 'wil->vring_tx_data' (local cap)
drivers/net/wireless/broadcom/b43legacy/pio.c:176 parse_cookie() warn: potential spectre issue 'queue->tx_packets_cache' (local cap)
drivers/net/wireless/intel/iwlwifi/mvm/tx.c:257 iwl_mvm_set_tx_cmd() warn: potential spectre issue 'tid_to_mac80211_ac' (local cap)
drivers/net/wireless/intel/iwlwifi/mvm/tx.c:809 iwl_mvm_tx_tso() warn: potential spectre issue 'tid_to_mac80211_ac' (local cap)
drivers/net/wireless/intel/iwlwifi/mvm/utils.c:706 iwl_mvm_update_txq_mapping() warn: potential spectre issue 'tid_to_mac80211_ac' (local cap)
drivers/net/wireless/quantenna/qtnfmac/core.c:48 qtnf_core_get_mac() warn: potential spectre issue 'bus->mac' (local cap)
drivers/net/wireless/realtek/rtlwifi/base.c:1433 rtl_action_proc() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/net/wireless/realtek/rtlwifi/base.c:1739 rtl_tx_agg_start() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/net/wireless/realtek/rtlwifi/base.c:1798 rtl_rx_agg_start() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/ntb/test/ntb_perf.c:1261 perf_dbgfs_write_run() warn: potential spectre issue 'perf->peers' (local cap)
drivers/pci/switch/switchtec.c:898 ioctl_port_to_pff() warn: potential spectre issue 'stdev->mmio_part_cfg_all' (local cap)
drivers/powercap/powercap_sys.c:137 show_constraint_power_limit_uw() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:138 store_constraint_power_limit_uw() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:139 show_constraint_time_window_us() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:140 store_constraint_time_window_us() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:141 show_constraint_max_power_uw() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:142 show_constraint_min_power_uw() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:143 show_constraint_max_time_window_us() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:144 show_constraint_min_time_window_us() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/powercap/powercap_sys.c:180 show_constraint_name() warn: potential spectre issue 'power_zone->constraints' (local cap)
drivers/ptp/ptp_chardev.c:252 ptp_ioctl() warn: potential spectre issue 'ops->pin_config' (local cap)
drivers/pwm/sysfs.c:351 unexport_store() warn: potential spectre issue 'chip->pwms' (local cap)
drivers/scsi/aacraid/aachba.c:3373 query_disk() warn: potential spectre issue 'fsa_dev_ptr' (local cap)
drivers/scsi/aacraid/commctrl.c:607 aac_send_raw_srb() warn: potential spectre issue 'dev->hba_map' (local cap)
drivers/scsi/gdth.c:2898 gdth_read_event() warn: potential spectre issue 'ebuffer' (local cap)
drivers/staging/comedi/comedi_fops.c:1047 do_chaninfo_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1107 do_bufinfo_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1281 parse_insn() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1581 __comedi_get_user_cmd() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1832 do_lock_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1864 do_unlock_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1898 do_cancel_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1931 do_poll_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:1967 do_setrsubd_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:2009 do_setwsubd_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/comedi_fops.c:869 do_bufconfig_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/drivers/usbduxfast.c:824 usbduxfast_ai_insn_read() warn: potential spectre issue '(devpriv->inbuf)' (local cap)
drivers/staging/comedi/range.c:65 do_rangeinfo_ioctl() warn: potential spectre issue 'dev->subdevices' (local cap)
drivers/staging/comedi/range.c:71 do_rangeinfo_ioctl() warn: potential spectre issue 's->range_table_list' (local cap)
drivers/staging/gdm724x/gdm_tty.c:83 gdm_tty_install() warn: potential spectre issue 'gdm_table[i]' (local cap)
drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c:494 cfs_cpt_spread_node() warn: potential spectre issue 'cptab->ctb_parts' (local cap)
drivers/staging/lustre/lnet/lnet/router_proc.c:445 proc_lnet_peers() warn: potential spectre issue 'the_lnet.ln_peer_tables' (local cap)
drivers/staging/lustre/lustre/lmv/lmv_obd.c:387 lmv_add_target() warn: potential spectre issue 'lmv->tgts' (local cap)
drivers/staging/lustre/lustre/lmv/lmv_obd.c:897 lmv_iocontrol() warn: potential spectre issue 'lmv->tgts' (local cap)
drivers/staging/lustre/lustre/lov/lov_obd.c:1130 lov_iocontrol() warn: potential spectre issue 'lov->lov_tgts' (local cap)
drivers/staging/lustre/lustre/lov/lov_obd.c:530 lov_add_target() warn: potential spectre issue 'lov->lov_tgts' (local cap)
drivers/staging/media/atomisp/i2c/atomisp-gc2235.c:978 gc2235_enum_frame_size() warn: potential spectre issue 'gc2235_res' (local cap)
drivers/staging/media/atomisp/i2c/atomisp-ov2722.c:1119 ov2722_enum_frame_size() warn: potential spectre issue 'ov2722_res' (local cap)
drivers/staging/media/atomisp/pci/atomisp2/atomisp_ioctl.c:617 atomisp_enum_input() warn: potential spectre issue 'isp->inputs' (local cap)
drivers/staging/media/imx/imx-media-csi.c:811 csi_g_frame_interval() warn: potential spectre issue 'priv->frame_interval' (local cap)
drivers/staging/media/imx/imx-media-utils.c:303 enum_format() warn: potential spectre issue 'yuv_formats' (local cap)
drivers/staging/media/imx/imx-media-utils.c:309 enum_format() warn: potential spectre issue 'rgb_formats' (local cap)
drivers/staging/media/imx/imx-media-vdic.c:807 vdic_g_frame_interval() warn: potential spectre issue 'priv->frame_interval' (local cap)
drivers/staging/rtlwifi/base.c:1421 rtl_action_proc() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/staging/rtlwifi/base.c:1724 rtl_tx_agg_start() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/staging/rtlwifi/base.c:1754 rtl_tx_agg_stop() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/staging/rtlwifi/base.c:1786 rtl_rx_agg_start() warn: potential spectre issue 'sta_entry->tids' (local cap)
drivers/staging/speakup/varhandlers.c:221 spk_set_num_var() warn: potential spectre issue 'spk_punc_masks' (local cap)
drivers/staging/wlan-ng/prism2mgmt.c:406 prism2mgmt_scan_results() warn: potential spectre issue 'hw->scanresults->info.hscanresult.result' (local cap)
drivers/thermal/cpu_cooling.c:401 cpufreq_set_cur_state() warn: potential spectre issue 'cpufreq_cdev->freq_table' (local cap)
drivers/thermal/int340x_thermal/int340x_thermal_zone.c:61 int340x_thermal_get_trip_temp() warn: potential spectre issue 'd->aux_trips' (local cap)
drivers/thermal/of-thermal.c:301 of_thermal_get_trip_type() warn: potential spectre issue 'data->trips' (local cap)
drivers/thermal/of-thermal.c:314 of_thermal_get_trip_temp() warn: potential spectre issue 'data->trips' (local cap)
drivers/thermal/of-thermal.c:349 of_thermal_get_trip_hyst() warn: potential spectre issue 'data->trips' (local cap)
drivers/tty/vt/vt.c:722 vc_cons_allocated() warn: potential spectre issue 'vc_cons' (local cap)
drivers/usb/common/common.c:58 usb_speed_string() warn: potential spectre issue 'speed_names' (local cap)
drivers/usb/gadget/function/f_fs.c:2309 __ffs_data_do_os_desc() warn: potential spectre issue 'data + 10' (local cap)
drivers/usb/gadget/function/f_fs.c:2309 __ffs_data_do_os_desc() warn: potential spectre issue 'data[10]' (local cap)
drivers/vhost/vhost.c:1358 vhost_vring_ioctl() warn: potential spectre issue 'd->vqs' (local cap)
drivers/video/fbdev/core/fbmem.c:142 fb_pad_unaligned_buffer() warn: potential spectre issue 'dst' (local cap)
drivers/video/fbdev/matrox/matroxfb_base.c:918 matroxfb_ioctl() warn: potential spectre issue 'minfo->outputs' (local cap)
drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:533 omapfb_get_ovl_colormode() warn: potential spectre issue 'fbdev->overlays' (local cap)
drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c:241 store_overlays() warn: potential spectre issue 'fbdev->overlays' (local cap)
fs/compat_ioctl.c:1404 compat_ioctl_check_table() warn: potential spectre issue 'ioctl_pointer' (local cap)
fs/file.c:629 __close_fd() warn: potential spectre issue 'fdt->fd' (local cap)
fs/nfsd/nfssvc.c:136 nfsd_vers() warn: potential spectre issue 'nfsd_version' (local cap)
fs/nfsd/nfssvc.c:150 nfsd_vers() warn: potential spectre issue 'nfsd_versions' (local cap)
fs/nfsd/nfssvc.c:184 nfsd_minorversion() warn: potential spectre issue 'nfsd_supported_minorversions' (local cap)
fs/quota/dquot.c:2376 vfs_load_quota_inode() warn: potential spectre issue 'dqopt->ops' (local cap)
fs/udf/partition.c:39 udf_get_pblock() warn: potential spectre issue 'sbi->s_partmaps' (local cap)
fs/udf/partition.c:68 udf_get_pblock_virt15() warn: potential spectre issue '(iinfo->i_ext.i_data + vdata->s_start_offset)' (local cap)
fs/xfs/scrub/scrub.c:341 xfs_scrub_validate_inputs() warn: potential spectre issue 'meta_scrub_ops' (local cap)
./include/media/v4l2-subdev.h:932 v4l2_subdev_get_try_format() warn: potential spectre issue 'cfg' (local cap)
ipc/sem.c:1359 semctl_setval() warn: potential spectre issue 'sma->sems' (local cap)
ipc/sem.c:1512 semctl_main() warn: potential spectre issue 'sma->sems' (local cap)
kernel/bpf/sockmap.c:1722 sock_map_ctx_update_elem() warn: potential spectre issue 'stab->sock_map' (local cap)
lib/nlattr.c:80 validate_nla() warn: potential spectre issue 'policy' (local cap)
lib/radix-tree.c:2195 idr_get_free() warn: potential spectre issue 'node->slots' (local cap)
net/atm/lec.c:711 lec_mcast_attach() warn: potential spectre issue 'dev_lec' (local cap)
net/bluetooth/smp.c:858 get_auth_method() warn: potential spectre issue 'sc_method' (local cap)
net/bluetooth/smp.c:860 get_auth_method() warn: potential spectre issue 'gen_method' (local cap)
net/compat.c:851 __do_compat_sys_socketcall() warn: potential spectre issue 'nas' (local cap)
net/core/sock_diag.c:226 __sock_diag_cmd() warn: potential spectre issue 'sock_diag_handlers' (local cap)
net/dcb/dcbnl.c:1727 dcb_doit() warn: potential spectre issue 'reply_funcs' (local cap)
net/decnet/dn_table.c:220 dn_new_zone() warn: potential spectre issue 'table->dh_zones' (local cap)
net/decnet/dn_table.c:543 dn_fib_table_insert() warn: potential spectre issue 'table->dh_zones' (local cap)
net/decnet/dn_table.c:679 dn_fib_table_delete() warn: potential spectre issue 'table->dh_zones' (local cap)
net/dsa/dsa_priv.h:141 dsa_master_find_slave() warn: potential spectre issue 'ds->ports' (local cap)
net/ipv4/ipmr.c:1608 ipmr_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/ipv4/ipmr.c:1682 ipmr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/ipv6/ip6mr.c:1850 ip6mr_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/ipv6/ip6mr.c:1924 ip6mr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' (local cap)
net/mac80211/wme.c:115 ieee80211_downgrade_queue() warn: potential spectre issue 'ieee802_1d_to_ac' (local cap)
net/netfilter/ipset/ip_set_core.c:2023 ip_set_sockfn_get() warn: potential spectre issue '(null)' (local cap)
net/netfilter/nfnetlink.c:119 nfnetlink_find_client() warn: potential spectre issue 'ss->cb' (local cap)
net/netfilter/nfnetlink.c:525 nfnetlink_bind() warn: potential spectre issue 'nfnl_group2type' (local cap)
net/netlink/af_netlink.c:693 netlink_create() warn: potential spectre issue 'nl_table' (local cap)
net/sctp/socket.c:6945 sctp_getsockopt_pr_streamstatus() warn: potential spectre issue 'asoc->stream.out' (local cap)
net/socket.c:2518 __do_sys_socketcall() warn: potential spectre issue 'nargs' (local cap)
net/tipc/node.c:1203 tipc_node_get_linkname() warn: potential spectre issue 'node->links' (local cap)
sound/core/seq/oss/seq_oss_event.c:315 note_on_event() warn: potential spectre issue 'info->ch' (local cap)
sound/core/seq/oss/seq_oss_event.c:362 note_off_event() warn: potential spectre issue 'info->ch' (local cap)
sound/core/seq/oss/seq_oss_synth.c:470 snd_seq_oss_synth_load_patch() warn: potential spectre issue 'dp->synths' (local cap)
sound/pci/asihpi/hpimsginit.c:70 hpi_init_response() warn: potential spectre issue 'res_size' (local cap)
sound/pci/rme9652/hdspm.c:5717 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_out' (local cap)
sound/pci/rme9652/hdspm.c:5734 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_in' (local cap)
sound/pci/rme9652/rme9652.c:2074 snd_rme9652_channel_info() warn: potential spectre issue 'rme9652->channel_map' (local cap)

arch/x86/events/amd/core.c:132 amd_pmu_event_map() warn: potential spectre issue 'amd_perfmon_event_map'
arch/x86/events/intel/core.c:337 intel_pmu_event_map() warn: potential spectre issue 'intel_perfmon_event_map'
arch/x86/events/intel/knc.c:122 knc_pmu_event_map() warn: potential spectre issue 'knc_perfmon_event_map'
arch/x86/events/intel/p4.c:722 p4_pmu_event_map() warn: potential spectre issue 'p4_general_events'
arch/x86/events/intel/p6.c:116 p6_pmu_event_map() warn: potential spectre issue 'p6_perfmon_event_map'
arch/x86/kvm/cpuid.c:822 move_to_next_stateful_cpuid_entry() warn: potential spectre issue 'vcpu->arch.cpuid_entries'
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2860 kvm_ioctl_create_device() warn: potential spectre issue 'kvm_device_ops_table'
block/deadline-iosched.c:56 deadline_rb_root() warn: potential spectre issue 'dd->sort_list'
crypto/anubis.c:497 anubis_setkey() warn: potential spectre issue 'kappa'
crypto/blowfish_common.c:369 blowfish_setkey() warn: potential spectre issue 'key'
drivers/acpi/acpica/dbutils.c:305 acpi_db_uint32_to_hex_string() warn: potential spectre issue 'acpi_gbl_upper_hex_digits'
drivers/acpi/acpica/utdecode.c:482 acpi_ut_get_notify_name() warn: potential spectre issue 'acpi_gbl_device_notify'
drivers/acpi/acpica/utdecode.c:485 acpi_ut_get_notify_name() warn: potential spectre issue 'acpi_gbl_processor_notify'
drivers/acpi/acpica/utdecode.c:488 acpi_ut_get_notify_name() warn: potential spectre issue 'acpi_gbl_thermal_notify'
drivers/acpi/acpi_video.c:308 video_set_cur_state() warn: potential spectre issue 'video->brightness->levels'
drivers/atm/idt77252.c:1291 idt77252_rx_raw() warn: potential spectre issue 'card->vcs'
drivers/block/rsxx/dma.c:715 rsxx_dma_queue_bio() warn: potential spectre issue 'dma_list'
drivers/char/applicom.c:418 ac_write() warn: potential spectre issue 'apbs'
drivers/crypto/chelsio/chtls/chtls_cm.c:114 assign_rxopt() warn: potential spectre issue 'cdev->mtus'
drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:496 amdgpu_debugfs_wave_read() warn: potential spectre issue 'data'
drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:553 amdgpu_debugfs_gpr_read() warn: potential spectre issue 'data'
drivers/gpu/drm/drm_ioc32.c:968 drm_compat_ioctl() warn: potential spectre issue 'drm_compat_ioctls'
drivers/gpu/drm/drm_ioctl.c:789 drm_ioctl() warn: potential spectre issue 'dev->driver->ioctls'
drivers/gpu/drm/i915/gvt/gvt.h:612 intel_gvt_mmio_is_unalign() warn: potential spectre issue 'gvt->mmio.mmio_attribute'
drivers/gpu/drm/i915/gvt/handlers.c:1274 dma_ctrl_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:1577 ring_reset_ctl_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:257 mul_force_wake_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:3109 intel_vgpu_mmio_reg_rw() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:3110 intel_vgpu_mmio_reg_rw() warn: potential spectre issue 'vgpu->mmio.sreg'
drivers/gpu/drm/i915/gvt/handlers.c:420 pipeconf_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:688 pch_adpa_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:701 south_chicken2_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:726 pri_surf_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:747 spr_surf_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/handlers.c:854 dp_aux_ch_ctl_mmio_write() warn: potential spectre issue 'vgpu->mmio.vreg'
drivers/gpu/drm/i915/gvt/kvmgt.c:1157 intel_vgpu_ioctl() warn: potential spectre issue 'vgpu->vdev.region'
drivers/gpu/drm/i915/i915_ioc32.c:88 i915_compat_ioctl() warn: potential spectre issue 'i915_compat_ioctls'
drivers/gpu/drm/i915/intel_sdvo.c:2146 intel_sdvo_connector_atomic_set_property() warn: potential spectre issue 'intel_sdvo_connector->tv_format_supported'
drivers/gpu/drm/mga/mga_ioc32.c:184 mga_compat_ioctl() warn: potential spectre issue 'mga_compat_ioctls'
drivers/gpu/drm/r128/r128_ioc32.c:190 r128_compat_ioctl() warn: potential spectre issue 'r128_compat_ioctls'
drivers/hid/hid-roccat-kone.c:43 kone_profile_activated() warn: potential spectre issue 'kone->profiles'
drivers/hid/hid-roccat-kovaplus.c:43 kovaplus_profile_activated() warn: potential spectre issue 'kovaplus->profile_settings'
drivers/hid/hid-roccat-pyra.c:41 profile_activated() warn: potential spectre issue 'pyra->profile_settings'
drivers/hid/hid-sensor-custom.c:310 show_value() warn: potential spectre issue 'sensor_inst->fields'
drivers/hid/hid-sensor-custom.c:414 store_value() warn: potential spectre issue 'sensor_inst->fields'
drivers/hid/usbhid/hiddev.c:113 hiddev_lookup_report() warn: potential spectre issue 'report_enum->report_id_hash'
drivers/hid/usbhid/hiddev.c:519 hiddev_ioctl_usage() warn: potential spectre issue 'field->value'
drivers/hwmon/aspeed-pwm-tacho.c:817 aspeed_pwm_cz_set_cur_state() warn: potential spectre issue 'cdev->cooling_levels'
drivers/hwmon/nct6775.c:2654 store_pwm_temp_sel() warn: potential spectre issue 'data->temp_src'
drivers/hwmon/nct6775.c:2698 store_pwm_weight_temp_sel() warn: potential spectre issue 'data->temp_src'
drivers/hwmon/via686a.c:288 TEMP_TO_REG() warn: potential spectre issue 'via_lut'
drivers/ide/ide-cd_ioctl.c:347 ide_cd_get_toc_entry() warn: potential spectre issue 'toc->ent'
drivers/infiniband/core/cache.c:486 __ib_cache_gid_get() warn: potential spectre issue 'ib_dev->cache.ports'
drivers/infiniband/core/cache.c:874 ib_get_cached_gid() warn: potential spectre issue 'device->cache.ports'
drivers/infiniband/core/cache.c:939 ib_get_cached_pkey() warn: potential spectre issue 'device->cache.ports'
drivers/infiniband/core/netlink.c:180 rdma_nl_rcv_msg() warn: potential spectre issue 'cb_table'
drivers/infiniband/core/netlink.c:90 is_nl_valid() warn: potential spectre issue 'rdma_nl_types'
drivers/infiniband/core/ucma.c:1664 ucma_write() warn: potential spectre issue 'ucma_cmd_table'
drivers/infiniband/core/ucm.c:1130 ib_ucm_write() warn: potential spectre issue 'ucm_cmd_table'
drivers/infiniband/core/uverbs_main.c:787 ib_uverbs_write() warn: potential spectre issue 'uverbs_ex_cmd_table'
drivers/infiniband/core/verbs.c:1280 ib_modify_qp_is_ok() warn: potential spectre issue 'qp_state_table[cur_state]'
drivers/infiniband/hw/cxgb4/cm.c:4104 process_work() warn: potential spectre issue 'work_handlers'
drivers/infiniband/hw/hfi1/sdma.c:789 sdma_select_engine_vl() warn: potential spectre issue 'm->map'
drivers/infiniband/hw/mthca/mthca_av.c:143 mthca_get_rate() warn: potential spectre issue 'dev->rate'
drivers/infiniband/hw/mthca/mthca_cmd.c:1796 mthca_MODIFY_QP() warn: potential spectre issue 'op'
drivers/infiniband/hw/mthca/mthca_cmd.c:1796 mthca_MODIFY_QP() warn: potential spectre issue 'op[cur]'
drivers/infiniband/hw/nes/nes.c:363 nes_get_qp() warn: potential spectre issue 'nesadapter->qp_table'
drivers/infiniband/hw/qib/qib_diag.c:594 qib_diagpkt_write() warn: potential spectre issue 'dd->pport'
drivers/infiniband/hw/qib/qib_iba7322.c:7667 find_best_ent() warn: potential spectre issue 'txdds_extra_sdr'
drivers/infiniband/hw/qib/qib_iba7322.c:7668 find_best_ent() warn: potential spectre issue 'txdds_extra_ddr'
drivers/infiniband/hw/qib/qib_iba7322.c:7669 find_best_ent() warn: potential spectre issue 'txdds_extra_qdr'
drivers/input/evdev.c:1241 evdev_do_ioctl() warn: potential spectre issue 'dev->absinfo'
drivers/input/input.c:236 input_handle_abs_event() warn: potential spectre issue 'mt->slots[mt->slot].abs'
drivers/isdn/capi/capi.c:268 capiminor_get() warn: potential spectre issue 'capiminors'
drivers/isdn/capi/capiutil.c:499 capi_cmd2str() warn: potential spectre issue 'mnames'
drivers/isdn/capi/kcapi.c:99 get_capi_ctr_by_nr() warn: potential spectre issue 'capi_controller'
drivers/isdn/gigaset/capi.c:2088 do_data_b3_req() warn: potential spectre issue 'cs->bcs'
drivers/isdn/hardware/eicon/message.c:404 api_put() warn: potential spectre issue 'a->plci'
drivers/isdn/hardware/mISDN/avmfritz.c:916 open_bchannel() warn: potential spectre issue 'fc->bch'
drivers/isdn/hardware/mISDN/hfcmulti.c:4110 open_bchannel() warn: potential spectre issue 'hc->chan'
drivers/isdn/hardware/mISDN/hfcpci.c:1948 open_bchannel() warn: potential spectre issue 'hc->bch'
drivers/isdn/hardware/mISDN/hfcsusb.c:491 open_bchannel() warn: potential spectre issue 'hw->bch'
drivers/isdn/hardware/mISDN/mISDNipac.c:1504 open_bchannel() warn: potential spectre issue 'ipac->hscx'
drivers/isdn/hardware/mISDN/mISDNisar.c:1654 isar_open() warn: potential spectre issue 'isar->ch'
drivers/isdn/hardware/mISDN/netjet.c:871 open_bchannel() warn: potential spectre issue 'card->bc'
drivers/isdn/hardware/mISDN/w6692.c:1014 open_bchannel() warn: potential spectre issue 'card->bc'
drivers/isdn/hisax/l3dss1.c:2988 dss1up() warn: potential spectre issue 'skb->data'
drivers/isdn/hisax/l3ni1.c:2936 ni1up() warn: potential spectre issue 'skb->data'
drivers/isdn/mISDN/dsp_audio.c:417 dsp_change_volume() warn: potential spectre issue 'volume_change'
drivers/md/bcache/request.c:369 iohash() warn: potential spectre issue 'dc->io_hash'
drivers/md/dm-integrity.c:455 access_page_list() warn: potential spectre issue 'pl'
drivers/md/dm-ioctl.c:1671 lookup_ioctl() warn: potential spectre issue '_ioctls'
drivers/md/dm-stats.c:543 dm_stat_for_entry() warn: potential spectre issue '(null)'
drivers/md/md-bitmap.c:132 bitmap_checkfree() warn: potential spectre issue 'bitmap->bp'
drivers/md/md-bitmap.c:1391 bitmap_get_counter() warn: potential spectre issue 'bitmap->bp'
drivers/md/md.c:1370 super_90_sync() warn: potential spectre issue 'sb->disks'
drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line() warn: potential spectre issue 'pin->error_inj_args'
drivers/media/common/saa7146/saa7146_video.c:530 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/common/videobuf2/videobuf2-core.c:1289 vb2_core_prepare_buf() warn: potential spectre issue 'q->bufs'
drivers/media/common/videobuf2/videobuf2-core.c:1377 vb2_core_qbuf() warn: potential spectre issue 'q->bufs'
drivers/media/dvb-core/dvb_net.c:252 handle_one_ule_extension() warn: potential spectre issue 'p->ule_next_hdr'
drivers/media/dvb-frontends/rtl2832_sdr.c:1037 rtl2832_sdr_enum_freq_bands() warn: potential spectre issue 'bands_adc'
drivers/media/i2c/adv7842.c:1992 adv7842_enum_mbus_code() warn: potential spectre issue 'adv7842_formats'
drivers/media/i2c/mt9m111.c:879 mt9m111_enum_mbus_code() warn: potential spectre issue 'mt9m111_colour_fmts'
drivers/media/i2c/noon010pc30.c:501 noon010_enum_mbus_code() warn: potential spectre issue 'noon010_formats'
drivers/media/i2c/ov2640.c:957 ov2640_enum_mbus_code() warn: potential spectre issue 'ov2640_codes'
drivers/media/i2c/ov2659.c:1031 ov2659_enum_frame_sizes() warn: potential spectre issue 'ov2659_framesizes'
drivers/media/i2c/ov5640.c:2408 ov5640_enum_mbus_code() warn: potential spectre issue 'ov5640_formats'
drivers/media/i2c/ov5645.c:913 ov5645_enum_frame_size() warn: potential spectre issue 'ov5645_mode_info_data'
drivers/media/i2c/ov5670.c:2165 ov5670_enum_frame_size() warn: potential spectre issue 'supported_modes'
drivers/media/i2c/ov5695.c:893 ov5695_enum_frame_sizes() warn: potential spectre issue 'supported_modes'
drivers/media/i2c/ov6650.c:722 ov6650_enum_mbus_code() warn: potential spectre issue 'ov6650_codes'
drivers/media/i2c/ov7670.c:1193 ov7670_enum_frame_interval() warn: potential spectre issue 'ov7670_frame_rates'
drivers/media/i2c/ov772x.c:1205 ov772x_enum_frame_interval() warn: potential spectre issue 'ov772x_frame_intervals'
drivers/media/i2c/ov9650.c:1108 ov965x_enum_frame_sizes() warn: potential spectre issue 'ov965x_framesizes'
drivers/media/i2c/s5c73m3/s5c73m3-core.c:1243 s5c73m3_enum_frame_size() warn: potential spectre issue 's5c73m3_resolutions[idx]'
drivers/media/i2c/s5c73m3/s5c73m3-core.c:1302 s5c73m3_oif_enum_frame_size() warn: potential spectre issue 's5c73m3_resolutions[idx]'
drivers/media/i2c/s5k5baf.c:1219 s5k5baf_enum_mbus_code() warn: potential spectre issue 's5k5baf_formats'
drivers/media/i2c/s5k6aa.c:1020 s5k6aa_enum_frame_interval() warn: potential spectre issue 's5k6aa_intervals'
drivers/media/i2c/s5k6aa.c:1037 s5k6aa_enum_mbus_code() warn: potential spectre issue 's5k6aa_formats'
drivers/media/i2c/soc_camera/ov9640.c:542 ov9640_enum_mbus_code() warn: potential spectre issue 'ov9640_codes'
drivers/media/i2c/soc_camera/rj54n1cb0c.c:495 rj54n1_enum_mbus_code() warn: potential spectre issue 'rj54n1_colour_fmts'
drivers/media/i2c/sr030pc30.c:482 sr030pc30_enum_mbus_code() warn: potential spectre issue 'sr030pc30_formats'
drivers/media/i2c/tda1997x.c:1745 tda1997x_enum_mbus_code() warn: potential spectre issue 'state->mbus_codes'
drivers/media/i2c/tvp7002.c:790 tvp7002_enum_dv_timings() warn: potential spectre issue 'tvp7002_timings'
drivers/media/i2c/upd64083.c:93 upd64083_read() warn: potential spectre issue 'buf'
drivers/media/i2c/vs6624.c:563 vs6624_enum_mbus_code() warn: potential spectre issue 'vs6624_formats'
drivers/media/pci/bt8xx/btcx-risc.c:111 btcx_screen_clips() warn: potential spectre issue 'clips'
drivers/media/pci/cx18/cx18-ioctl.c:493 cx18_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/pci/cx88/cx88-video.c:857 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/pci/saa7134/saa7134-video.c:1825 saa7134_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/pci/saa7134/saa7134-video.c:1844 saa7134_enum_fmt_vid_overlay() warn: potential spectre issue 'formats'
drivers/media/pci/saa7134/saa7134-video.c:421 saa7134_set_decoder() warn: potential spectre issue 'saa7134_boards[dev->board].inputs'
drivers/media/pci/saa7146/hexium_gemini.c:188 hexium_set_input() warn: potential spectre issue 'hexium_input_select'
drivers/media/pci/saa7146/hexium_orion.c:317 hexium_set_input() warn: potential spectre issue 'hexium_input_select'
drivers/media/pci/saa7164/saa7164-api.c:455 saa7164_api_set_videomux() warn: potential spectre issue 'inputs'
drivers/media/pci/tw686x/tw686x-video.c:984 tw686x_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/pci/tw68/tw68-video.c:795 tw68_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/platform/am437x/am437x-vpfe.c:1737 vpfe_enum_input() warn: potential spectre issue 'sdinfo->inputs'
drivers/media/platform/am437x/am437x-vpfe.c:1778 vpfe_set_input() warn: potential spectre issue 'sdinfo->routes'
drivers/media/platform/davinci/vpfe_capture.c:1048 vpfe_enum_input() warn: potential spectre issue 'sdinfo->inputs'
drivers/media/platform/davinci/vpfe_capture.c:1098 vpfe_s_input() warn: potential spectre issue 'sdinfo->routes'
drivers/media/platform/exynos4-is/fimc-lite.c:675 fimc_lite_enum_fmt_mplane() warn: potential spectre issue 'fimc_lite_formats'
drivers/media/platform/exynos4-is/mipi-csis.c:549 s5pcsis_enum_mbus_code() warn: potential spectre issue 's5pcsis_formats'
drivers/media/platform/fsl-viu.c:587 vidioc_enum_fmt() warn: potential spectre issue 'formats'
drivers/media/platform/marvell-ccic/mcam-core.c:1323 mcam_vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'mcam_formats'
drivers/media/platform/omap/omap_vout.c:1062 vidioc_enum_fmt_vid_out() warn: potential spectre issue 'omap_formats'
drivers/media/platform/omap/omap_vout.c:1530 vidioc_dqbuf() warn: potential spectre issue 'q->bufs'
drivers/media/platform/rcar_drif.c:909 rcar_drif_enum_fmt_sdr_cap() warn: potential spectre issue 'formats'
drivers/media/platform/rcar-vin/rcar-v4l2.c:344 rvin_enum_fmt_vid_cap() warn: potential spectre issue 'rvin_formats'
drivers/media/platform/renesas-ceu.c:1081 ceu_enum_fmt_vid_cap() warn: potential spectre issue 'ceu_fmt_list'
drivers/media/platform/s5p-g2d/g2d.c:311 vidioc_enum_fmt() warn: potential spectre issue 'formats'
drivers/media/platform/sh_vou.c:407 sh_vou_enum_fmt_vid_out() warn: potential spectre issue 'vou_fmt'
drivers/media/platform/sti/bdisp/bdisp-v4l2.c:711 bdisp_enum_fmt() warn: potential spectre issue 'bdisp_formats'
drivers/media/platform/vimc/vimc-common.c:182 vimc_pix_map_by_index() warn: potential spectre issue 'vimc_pix_map_list'
drivers/media/platform/vimc/vimc-debayer.c:182 vimc_deb_enum_mbus_code() warn: potential spectre issue 'vimc_deb_pix_map_list'
drivers/media/platform/vivid/vivid-sdr-cap.c:323 vivid_sdr_enum_freq_bands() warn: potential spectre issue 'bands_adc'
drivers/media/platform/vivid/vivid-vid-cap.c:1043 vidioc_enum_fmt_vid_overlay() warn: potential spectre issue 'formats_ovl'
drivers/media/platform/vivid/vivid-vid-common.c:736 vivid_enum_fmt_vid() warn: potential spectre issue 'vivid_formats'
drivers/media/platform/vsp1/vsp1_rwpf.c:47 vsp1_rwpf_enum_mbus_code() warn: potential spectre issue 'codes'
drivers/media/radio/radio-raremono.c:201 vidioc_enum_freq_bands() warn: potential spectre issue 'bands'
drivers/media/radio/si470x/radio-si470x-common.c:758 si470x_vidioc_enum_freq_bands() warn: potential spectre issue 'bands'
drivers/media/spi/gs1662.c:326 gs_enum_dv_timings() warn: potential spectre issue 'fmt_cap'
drivers/media/usb/em28xx/em28xx-video.c:1958 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'format'
drivers/media/usb/go7007/go7007-v4l2.c:710 go7007_s_input() warn: potential spectre issue 'go->board_info->inputs'
drivers/media/usb/pvrusb2/pvrusb2-ctrl.c:208 pvr2_ctrl_get_valname() warn: potential spectre issue 'names'
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:413 ctrl_channel_set() warn: potential spectre issue 'hdw->freqTable'
drivers/media/usb/s2255/s2255drv.c:753 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/media/usb/tm6000/tm6000-video.c:879 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'format'
drivers/media/usb/uvc/uvc_v4l2.c:617 uvc_ioctl_enum_fmt() warn: potential spectre issue 'stream->format'
drivers/misc/eeprom/max6875.c:68 max6875_update_slice() warn: potential spectre issue 'data->data'
drivers/misc/hmc6352.c:54 compass_store() warn: potential spectre issue 'map'
drivers/misc/mic/scif/scif_dma.c:711 scif_ordered_memcpy_toio() warn: potential spectre issue 'src'
drivers/misc/mic/scif/scif_dma.c:732 scif_ordered_memcpy_fromio() warn: potential spectre issue 'src'
drivers/misc/mic/scif/scif_dma.c:771 scif_off_to_dma_addr() warn: potential spectre issue 'window->dma_addr'
drivers/misc/mic/scif/scif_fence.c:193 scif_get_local_va() warn: potential spectre issue 'pages'
drivers/misc/mic/vop/vop_vringh.c:856 vop_virtio_copy_desc() warn: potential spectre issue 'vdev->vvr'
drivers/misc/pci_endpoint_test.c:124 pci_endpoint_test_bar_readl() warn: potential spectre issue 'test->bar'
drivers/misc/vmw_vmci/vmci_event.c:99 event_deliver() warn: potential spectre issue 'subscriber_array'
drivers/mtd/ubi/build.c:271 ubi_get_device() warn: potential spectre issue 'ubi_devices'
drivers/mtd/ubi/eba.c:451 ubi_eba_is_mapped() warn: potential spectre issue 'vol->eba_tbl->entries'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:134 bnx2x_move_fp() warn: potential spectre issue 'bp->bnx2x_txq'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:2475 bnx2x_bz_fp() warn: potential spectre issue 'bp->bnx2x_txq'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:4523 bnx2x_alloc_fp_mem_at() warn: potential spectre issue 'bp->fp'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546 bnx2x_prep_fw_stats_req() warn: potential spectre issue 'bp->fp'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2077 set_eeprom() warn: potential spectre issue 'buf'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2272 cxgb_extension_ioctl() warn: potential spectre issue 'adapter->params.sge.qset'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2286 cxgb_extension_ioctl() warn: potential spectre issue 'adapter->msix_info'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:768 do_stid_rpl() warn: potential spectre issue 't3c_tid->client->handlers'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:786 do_hwtid_rpl() warn: potential spectre issue 't3c_tid->client->handlers'
drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c:853 do_abort_req_rss() warn: potential spectre issue 't3c_tid->client->handlers'
drivers/net/ethernet/chelsio/cxgb3/sge.c:2087 rx_eth() warn: potential spectre issue 'adap->port'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:1153 set_eeprom() warn: potential spectre issue 'buf'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:1503 cxgb4_get_module_eeprom() warn: potential spectre issue 'data'
drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.h:263 cxgbi_ppm_get_tag_caller_data() warn: potential spectre issue 'ppm->ppod_data'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:527 e1000_set_eeprom() warn: potential spectre issue 'eeprom_buff'
drivers/net/ethernet/intel/e1000e/ethtool.c:614 e1000_set_eeprom() warn: potential spectre issue 'eeprom_buff'
drivers/net/ethernet/intel/igb/igb_ethtool.c:833 igb_set_eeprom() warn: potential spectre issue 'eeprom_buff'
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:989 ixgbe_set_eeprom() warn: potential spectre issue 'eeprom_buff'
drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:130 mlx5e_select_queue() warn: potential spectre issue 'priv->channel_tc2txq[channel_ix]'
drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c:816 ethtool_flow_to_nfp_flag() warn: potential spectre issue 'xlate_ethtool_to_nfp'
drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:213 qlcnic_add_lb_filter() warn: potential spectre issue 'adapter->rx_fhash.fhead'
drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:235 qlcnic_add_lb_filter() warn: potential spectre issue 'adapter->fhash.fhead'
drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:331 qlcnic_send_filter() warn: potential spectre issue 'adapter->fhash.fhead'
drivers/net/ethernet/sfc/ef10.c:4583 efx_ef10_filter_remove_internal() warn: potential spectre issue 'table->entry'
drivers/net/ethernet/sfc/falcon/farch.c:2300 ef4_farch_filter_id_table_id() warn: potential spectre issue 'ef4_farch_filter_range_table'
drivers/net/ethernet/sfc/falcon/farch.c:2549 ef4_farch_filter_remove_safe() warn: potential spectre issue 'table->spec'
drivers/net/ethernet/sfc/falcon/farch.c:2577 ef4_farch_filter_get_safe() warn: potential spectre issue 'table->spec'
drivers/net/ethernet/sfc/farch.c:2359 efx_farch_filter_id_table_id() warn: potential spectre issue 'efx_farch_filter_range_table'
drivers/net/ieee802154/atusb.c:313 atusb_in_good() warn: potential spectre issue 'skb->data'
drivers/net/usb/asix_common.c:701 asix_set_eeprom() warn: potential spectre issue 'eeprom_buff'
drivers/net/wireless/ath/ath10k/htt.h:1492 ath10k_htt_get_tx_fetch_ind_resp_ids() warn: potential spectre issue 'ind->records'
drivers/net/wireless/ath/ath10k/htt_rx.c:2597 ath10k_htt_fetch_peer_stats() warn: potential spectre issue 'resp->peer_tx_stats.payload'
drivers/net/wireless/ath/ath10k/usb.c:290 ath10k_usb_tx_complete() warn: potential spectre issue 'ar->htc.endpoint'
drivers/net/wireless/ath/ath10k/usb.c:307 ath10k_usb_rx_complete() warn: potential spectre issue 'ar->htc.endpoint'
drivers/net/wireless/ath/ath6kl/htc_pipe.c:757 ath6kl_htc_pipe_tx_complete() warn: potential spectre issue 'target->endpoint'
drivers/net/wireless/ath/ath6kl/main.c:71 ath6kl_add_new_sta() warn: potential spectre issue 'ar->sta_list'
drivers/net/wireless/ath/ath6kl/txrx.c:531 ath6kl_indicate_tx_activity() warn: potential spectre issue 'ar->ac2ep_map'
drivers/net/wireless/ath/ath6kl/txrx.c:549 ath6kl_indicate_tx_activity() warn: potential spectre issue 'ar->ac_stream_pri_map'
drivers/net/wireless/ath/ath6kl/wmi.c:1538 ath6kl_wmi_cac_event_rx() warn: potential spectre issue 'wmi->stream_exist_for_ac'
drivers/net/wireless/ath/ath9k/htc_hst.c:118 htc_process_conn_rsp() warn: potential spectre issue 'target->endpoint'
drivers/net/wireless/ath/ath9k/htc_hst.c:339 ath9k_htc_txcompletion_cb() warn: potential spectre issue 'htc_handle->endpoint'
drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1102 brcms_c_aggregatable() warn: potential spectre issue 'wlc->ampdu->ini_enable'
drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:494 brcms_c_ampdu_tx_operational() warn: potential spectre issue 'scb_ampdu->ini'
drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:664 brcms_c_ampdu_finalize() warn: potential spectre issue 'ampdu->fifo_tb'
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c:2549 wlc_phy_rssi_compute() warn: potential spectre issue 'lcnphy_gain_index_offset_for_pkt_rssi'
drivers/net/wireless/intel/iwlegacy/3945.c:1385 il3945_hw_reg_set_scan_power() warn: potential spectre issue 'power_gain_table[band_idx]'
drivers/net/wireless/intel/iwlwifi/dvm/tx.c:520 iwlagn_tx_agg_stop() warn: potential spectre issue 'priv->tid_data[sta_id]'
drivers/net/wireless/intel/iwlwifi/dvm/tx.c:668 iwlagn_tx_agg_flush() warn: potential spectre issue 'priv->tid_data[sta_id]'
drivers/net/wireless/intel/iwlwifi/dvm/tx.c:710 iwlagn_tx_agg_oper() warn: potential spectre issue 'priv->tid_data[sta_priv->sta_id]'
drivers/net/wireless/intel/iwlwifi/dvm/tx.c:715 iwlagn_tx_agg_oper() warn: potential spectre issue 'tid_to_ac'
drivers/net/wireless/intel/iwlwifi/mvm/sta.c:2610 iwl_mvm_sta_tx_agg_oper() warn: potential spectre issue 'tid_to_mac80211_ac'
drivers/net/wireless/intersil/hostap/hostap_main.c:390 hostap_set_encryption() warn: potential spectre issue 'local->crypt_info.crypt'
drivers/net/wireless/st/cw1200/txrx.c:1029 cw1200_rx_cb() warn: potential spectre issue 'priv->link_id_db'
drivers/net/wireless/st/cw1200/wsm.c:1260 wsm_handle_exception() warn: potential spectre issue 'buf.begin'
drivers/net/wireless/st/cw1200/wsm.c:1312 wsm_handle_rx() warn: potential spectre issue 'wsm_buf.begin'
drivers/nfc/st21nfca/se.c:341 st21nfca_connectivity_event_received() warn: potential spectre issue 'skb->data'
drivers/nfc/st-nci/se.c:356 st_nci_hci_connectivity_event_received() warn: potential spectre issue 'skb->data'
drivers/pci/pci-sysfs.c:923 pci_write_config() warn: potential spectre issue 'data'
drivers/pci/switch/switchtec.c:728 event_hdr_addr() warn: potential spectre issue 'event_regs'
drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential spectre issue 'pcfg->dsp_pff_inst_id'
drivers/rapidio/rio-sysfs.c:215 rio_write_config() warn: potential spectre issue 'data'
drivers/rtc/rtc-lib.c:35 rtc_month_days() warn: potential spectre issue 'rtc_days_in_month'
drivers/rtc/rtc-lib.c:44 rtc_year_days() warn: potential spectre issue 'rtc_ydays[is_leap_year(year)]'
drivers/scsi/csiostor/csio_wr.c:1168 csio_wr_process_iq() warn: potential spectre issue 'hw->wrm.intr_map'
drivers/scsi/dpt_i2o.c:1726 adpt_i2o_passthru() warn: potential spectre issue 'user_msg'
drivers/scsi/megaraid.c:3143 megadev_ioctl() warn: potential spectre issue 'hba_soft_state'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1550 _ctl_diag_register_2() warn: potential spectre issue 'ioc->diag_buffer'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1559 _ctl_diag_register_2() warn: potential spectre issue 'ioc->diag_buffer_dma'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1601 _ctl_diag_register_2() warn: potential spectre issue 'ioc->product_specific'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1784 _ctl_diag_unregister() warn: potential spectre issue 'ioc->diag_buffer'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1792 _ctl_diag_unregister() warn: potential spectre issue 'ioc->diag_buffer_sz'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1793 _ctl_diag_unregister() warn: potential spectre issue 'ioc->diag_buffer_dma'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1854 _ctl_diag_query() warn: potential spectre issue 'ioc->diag_buffer'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1872 _ctl_diag_query() warn: potential spectre issue 'ioc->product_specific'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1874 _ctl_diag_query() warn: potential spectre issue 'ioc->diag_buffer_sz'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1876 _ctl_diag_query() warn: potential spectre issue 'ioc->unique_id'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:1877 _ctl_diag_query() warn: potential spectre issue 'ioc->diagnostic_flags'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:2053 _ctl_diag_release() warn: potential spectre issue 'ioc->diag_buffer'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:2127 _ctl_diag_read_buffer() warn: potential spectre issue 'ioc->diag_buffer'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:2135 _ctl_diag_read_buffer() warn: potential spectre issue 'ioc->diag_buffer_sz'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:2210 _ctl_diag_read_buffer() warn: potential spectre issue 'ioc->diag_buffer_dma'
drivers/scsi/mpt3sas/mpt3sas_ctl.c:2213 _ctl_diag_read_buffer() warn: potential spectre issue 'ioc->product_specific'
drivers/scsi/qedi/qedi_iscsi.c:1225 qedi_set_path() warn: potential spectre issue 'qedi->ep_tbl'
drivers/staging/comedi/comedi_fops.c:1678 do_cmd_ioctl() warn: potential spectre issue 'dev->subdevices'
drivers/staging/comedi/comedi_fops.c:1785 do_cmdtest_ioctl() warn: potential spectre issue 'dev->subdevices'
drivers/staging/comedi/comedi_fops.c:218 comedi_dev_get_from_board_minor() warn: potential spectre issue 'comedi_board_minor_table'
drivers/staging/comedi/drivers/adv_pci1720.c:86 pci1720_ao_insn_write() warn: potential spectre issue 's->readback'
drivers/staging/comedi/drivers/amplc_dio200_common.c:530 dio200_subdev_8254_config() warn: potential spectre issue 'i8254->gate_src'
drivers/staging/comedi/drivers/amplc_dio200_common.c:541 dio200_subdev_8254_config() warn: potential spectre issue 'i8254->clock_src'
drivers/staging/comedi/drivers/amplc_pci224.c:397 pci224_ao_set_data() warn: potential spectre issue 'board->ao_hwrange'
drivers/staging/comedi/drivers/amplc_pci230.c:781 pci230_ai_insn_read() warn: potential spectre issue 'pci230_ai_gain'
drivers/staging/comedi/drivers.c:249 comedi_readback_insn_read() warn: potential spectre issue 's->readback'
drivers/staging/comedi/drivers/../comedidev.h:644 comedi_range_is_bipolar() warn: potential spectre issue 's->range_table->range'
drivers/staging/comedi/drivers/../comedidev.h:665 comedi_range_is_unipolar() warn: potential spectre issue 's->range_table->range'
drivers/staging/comedi/drivers/../comedidev.h:709 comedi_chan_range_is_bipolar() warn: potential spectre issue 's->range_table_list'
drivers/staging/comedi/drivers/../comedidev.h:709 comedi_chan_range_is_bipolar() warn: potential spectre issue 's->range_table_list[chan]->range'
drivers/staging/comedi/drivers/comedi_test.c:424 waveform_ai_insn_read() warn: potential spectre issue 'devpriv->ao_loopbacks'
drivers/staging/comedi/drivers/dt2815.c:80 dt2815_ao_insn_read() warn: potential spectre issue 'devpriv->ao_readback'
drivers/staging/comedi/drivers/dyna_pci10xx.c:112 dyna_pci10xx_insn_write_ao() warn: potential spectre issue 'range_codes_pci1050_ai'
drivers/staging/comedi/drivers/dyna_pci10xx.c:75 dyna_pci10xx_insn_read_ai() warn: potential spectre issue 'range_codes_pci1050_ai'
drivers/staging/comedi/drivers/icp_multi.c:120 icp_multi_ai_insn_read() warn: potential spectre issue 'range_codes_analog'
drivers/staging/comedi/drivers/icp_multi.c:166 icp_multi_ao_insn_write() warn: potential spectre issue 'range_codes_analog'
drivers/staging/comedi/drivers/ni_660x.c:649 ni_660x_dio_insn_config() warn: potential spectre issue 'devpriv->io_cfg'
drivers/staging/comedi/drivers/ni_mio_common.c:4368 ni_calib_insn_read() warn: potential spectre issue 'devpriv->caldacs'
drivers/staging/comedi/drivers/ni_mio_common.c:4475 ni_m_series_eeprom_insn_read() warn: potential spectre issue 'devpriv->eeprom_buffer'
drivers/staging/comedi/drivers/rtd520.c:1118 rtd_counter_insn_config() warn: potential spectre issue 'devpriv->timer_gate_src'
drivers/staging/comedi/drivers/rtd520.c:1152 rtd_counter_insn_config() warn: potential spectre issue 'devpriv->timer_clk_src'
drivers/staging/comedi/drivers/serial2002.c:565 serial2002_di_insn_read() warn: potential spectre issue 'devpriv->digital_in_mapping'
drivers/staging/comedi/drivers/serial2002.c:589 serial2002_do_insn_write() warn: potential spectre issue 'devpriv->digital_out_mapping'
drivers/staging/comedi/drivers/serial2002.c:610 serial2002_ai_insn_read() warn: potential spectre issue 'devpriv->analog_in_mapping'
drivers/staging/comedi/drivers/serial2002.c:634 serial2002_ao_insn_write() warn: potential spectre issue 'devpriv->analog_out_mapping'
drivers/staging/comedi/drivers/serial2002.c:657 serial2002_ao_insn_read() warn: potential spectre issue 'devpriv->ao_readback'
drivers/staging/comedi/drivers/serial2002.c:671 serial2002_encoder_insn_read() warn: potential spectre issue 'devpriv->encoder_in_mapping'
drivers/staging/comedi/drivers/usbdux.c:1073 usbdux_counter_read() warn: potential spectre issue 'devpriv->insn_buf'
drivers/staging/comedi/drivers/vmk80xx.c:343 vmk80xx_ao_insn_read() warn: potential spectre issue 'devpriv->usb_rx_buf'
drivers/staging/dgnc/dgnc_tty.c:844 dgnc_tty_open() warn: potential spectre issue 'brd->channels'
./drivers/staging/lustre/include/linux/lnet/lib-lnet.h:381 lnet_net2rnethash() warn: potential spectre issue 'the_lnet.ln_remote_nets_hash'
./drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h:1142 hur_data() warn: potential spectre issue 'hur->hur_user_item'
drivers/staging/lustre/lnet/lnet/api-ni.c:722 lnet_cpt_of_nid_locked() warn: potential spectre issue 'ni->ni_cpts'
drivers/staging/lustre/lnet/lnet/peer.c:250 lnet_find_peer_locked() warn: potential spectre issue 'ptable->pt_hash'
drivers/staging/lustre/lnet/lnet/peer.c:277 lnet_nid2peer_locked() warn: potential spectre issue 'the_lnet.ln_peer_tables'
drivers/staging/lustre/lnet/lnet/router_proc.c:457 proc_lnet_peers() warn: potential spectre issue 'ptable->pt_hash'
drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c:1752 mt9m114_enum_frame_size() warn: potential spectre issue 'mt9m114_res'
drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c:218 isp_subdev_enum_mbus_code() warn: potential spectre issue 'atomisp_in_fmt_conv'
drivers/staging/media/davinci_vpfe/dm365_ipipeif.c:560 ipipeif_enum_mbus_code() warn: potential spectre issue 'ipipeif_input_fmts'
drivers/staging/media/davinci_vpfe/dm365_isif.c:1518 isif_enum_mbus_code() warn: potential spectre issue 'isif_fmts'
drivers/staging/media/davinci_vpfe/dm365_resizer.c:1520 resizer_enum_mbus_code() warn: potential spectre issue 'resizer_output_formats'
drivers/staging/media/davinci_vpfe/vpfe_video.c:874 vpfe_s_input() warn: potential spectre issue 'sdinfo->routes'
drivers/staging/media/omap4iss/iss_csi2.c:912 csi2_enum_mbus_code() warn: potential spectre issue 'csi2_input_fmts'
drivers/staging/media/omap4iss/iss_ipipeif.c:460 ipipeif_enum_mbus_code() warn: potential spectre issue 'ipipeif_fmts'
drivers/staging/media/tegra-vde/tegra-vde.c:291 tegra_vde_setup_iram_tables() warn: potential spectre issue 'dpb_frames'
drivers/staging/ncpfs/ncplib_kernel.c:108 ncp_reply_data() warn: potential spectre issue 'server->packet'
drivers/staging/rtl8192e/rtllib.h:995 eap_get_type() warn: potential spectre issue 'eap_types'
drivers/staging/rtl8192u/ieee80211/ieee80211.h:1190 eap_get_type() warn: potential spectre issue 'eap_types'
drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:663 vidioc_enum_fmt_vid_overlay() warn: potential spectre issue 'formats'
drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:872 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'formats'
drivers/thermal/int340x_thermal/int3406_thermal.c:64 int3406_thermal_set_cur_state() warn: potential spectre issue 'd->br->levels'
drivers/thermal/intel_soc_dts_iosf.c:210 sys_set_trip_temp() warn: potential spectre issue 'dts->trip_types'
drivers/thermal/intel_soc_dts_iosf.c:223 sys_get_trip_type() warn: potential spectre issue 'dts->trip_types'
drivers/tty/cyclades.c:1504 cy_open() warn: potential spectre issue 'cy_card[i].ports'
drivers/tty/n_gsm.c:369 gsm_fcs_add() warn: potential spectre issue 'gsm_fcs8'
drivers/tty/rocket.c:876 rp_open() warn: potential spectre issue 'rp_table'
drivers/tty/tty_io.c:1162 tty_driver_lookup_tty() warn: potential spectre issue 'driver->ttys'
drivers/tty/tty_io.c:1186 tty_init_termios() warn: potential spectre issue 'tty->driver->termios'
drivers/tty/tty_io.c:1329 tty_init_dev() warn: potential spectre issue 'driver->ports'
drivers/tty/tty_io.c:1380 tty_free_termios() warn: potential spectre issue 'tty->driver->termios'
drivers/tty/tty_ldisc.c:117 get_ldops() warn: potential spectre issue 'tty_ldiscs'
drivers/tty/vt/keyboard.c:1871 vt_do_kdsk_ioctl() warn: potential spectre issue 'key_map'
drivers/tty/vt/vt.c:2319 do_con_write() warn: potential spectre issue 'vc->vc_translate'
drivers/tty/vt/vt.c:2884 con_install() warn: potential spectre issue 'vc_cons'
drivers/tty/vt/vt.c:733 visual_init() warn: potential spectre issue 'con_driver_map'
drivers/tty/vt/vt_ioctl.c:711 vt_ioctl() warn: potential spectre issue 'vc_cons'
drivers/usb/core/config.c:374 usb_parse_endpoint() warn: potential spectre issue 'maxpacket_maxes'
drivers/usb/core/hub.c:1865 find_port_owner() warn: potential spectre issue 'hub->ports'
drivers/usb/gadget/function/f_fs.c:2795 __ffs_func_bind_do_nums() warn: potential spectre issue 'func->interfaces_nums'
drivers/usb/gadget/function/f_fs.c:2800 __ffs_func_bind_do_nums() warn: potential spectre issue 'func->ffs->stringtabs[0]->strings'
drivers/usb/gadget/function/f_fs.c:2840 __ffs_func_bind_do_os_desc() warn: potential spectre issue 'func->function.os_desc_table'
drivers/usb/gadget/function/f_fs.c:2841 __ffs_func_bind_do_os_desc() warn: potential spectre issue 'func->interfaces_nums'
drivers/usb/gadget/function/u_serial.c:600 gs_open() warn: potential spectre issue 'ports'
drivers/usb/host/ehci-hub.c:533 set_owner() warn: potential spectre issue 'ehci->regs->port_status'
drivers/usb/misc/sisusbvga/sisusb_con.c:148 sisusb_get_sisusb() warn: potential spectre issue 'mysisusbs'
drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
drivers/vfio/pci/vfio_pci.c:734 vfio_pci_ioctl() warn: potential spectre issue 'vdev->region'
drivers/video/console/vgacon.c:206 vgacon_scrollback_init() warn: potential spectre issue 'vgacon_scrollbacks'
drivers/video/fbdev/aty/atyfb_base.c:2916 atyfb_setcolreg() warn: potential spectre issue 'par->palette'
drivers/video/fbdev/aty/radeon_base.c:1209 radeon_setcolreg() warn: potential spectre issue 'rinfo->palette'
drivers/video/fbdev/core/fbcon.c:2191 fbcon_switch() warn: potential spectre issue 'con2fb_map'
drivers/video/fbdev/core/fbcon.c:656 set_blitting_type() warn: potential spectre issue 'fb_display'
drivers/video/fbdev/cyber2000fb.c:344 cyber2000fb_setcolreg() warn: potential spectre issue 'cfb->palette'
drivers/video/fbdev/mb862xx/mb862xxfb_accel.c:112 mb86290fb_imageblit1() warn: potential spectre issue 'cmd'
fs/btrfs/raid56.c:951 page_in_rbio() warn: potential spectre issue 'rbio->bio_pages'
fs/btrfs/raid56.c:957 page_in_rbio() warn: potential spectre issue 'rbio->stripe_pages'
fs/dlm/lock.c:596 find_rsb_dir() warn: potential spectre issue 'ls->ls_rsbtbl'
fs/dlm/lock.c:741 find_rsb_nodir() warn: potential spectre issue 'ls->ls_rsbtbl'
fs/exofs/dir.c:233 exofs_set_de_type() warn: potential spectre issue 'exofs_type_by_mode'
fs/ext2/dir.c:281 ext2_set_de_type() warn: potential spectre issue 'ext2_type_by_mode'
fs/ext4/ext4.h:3049 ext4_set_de_type() warn: potential spectre issue 'ext4_type_by_mode'
fs/f2fs/dir.c:65 set_de_type() warn: potential spectre issue 'f2fs_type_by_mode'
fs/fat/nfs.c:94 __fat_nfs_get_inode() warn: potential spectre issue 'de'
fs/hugetlbfs/inode.c:240 hugetlbfs_read_actor() warn: potential spectre issue 'page'
fs/jfs/jfs_dmap.c:1640 dbDiscardAG() warn: potential spectre issue 'bmp->db_bmap.dn_agfree'
fs/jfs/jfs_dmap.c:2541 dbAdjCtl() warn: potential spectre issue 'dcp->stree'
fs/jfs/jfs_dmap.c:2931 dbAdjTree() warn: potential spectre issue 'tp->t1.stree'
fs/nilfs2/dir.c:269 nilfs_set_de_type() warn: potential spectre issue 'nilfs_type_by_mode'
fs/ocfs2/quota_global.c:350 ocfs2_global_read_info() warn: potential spectre issue 'ino'
fs/ocfs2/quota_local.c:200 ocfs2_local_check_quota_file() warn: potential spectre issue 'ino'
fs/ocfs2/quota_local.c:750 ocfs2_local_read_info() warn: potential spectre issue 'rec->r_list'
fs/quota/dquot.c:2115 dquot_commit_info() warn: potential spectre issue 'dqopt->ops'
fs/quota/dquot.c:936 dqinit_needed() warn: potential spectre issue 'dquots'
fs/quota/quota.c:110 quota_getfmt() warn: potential spectre issue 'sb_dqopt(sb)->info'
fs/quota/quota_v1.c:201 v1_write_file_info() warn: potential spectre issue 'dqopt->info'
fs/udf/partition.c:122 udf_get_pblock_spar15() warn: potential spectre issue 'sbi->s_partmaps'
fs/udf/partition.c:295 udf_try_read_meta() warn: potential spectre issue 'UDF_SB(sb)->s_partmaps'
fs/udf/partition.c:317 udf_get_pblock_meta25() warn: potential spectre issue 'sbi->s_partmaps'
fs/udf/partition.c:58 udf_get_pblock_virt15() warn: potential spectre issue 'sbi->s_partmaps'
fs/xfs/libxfs/xfs_rtbitmap.c:320 xfs_rtfind_forw() warn: potential spectre issue 'bufp'
fs/xfs/scrub/scrub.c:426 xfs_scrub_metadata() warn: potential spectre issue 'meta_scrub_ops'
./include/linux/input/mt.h:65 input_mt_get_value() warn: potential spectre issue 'slot->abs'
./include/linux/mISDNif.h:346 test_channelmap() warn: potential spectre issue 'map'
./include/linux/mmzone.h:1161 __nr_to_section() warn: potential spectre issue 'mem_section[(nr / (((1) << 12) / 32))]'
./include/linux/mtd/map.h:375 map_word_load_partial() warn: potential spectre issue 'buf'
./include/linux/rhashtable.h:431 rht_bucket() warn: potential spectre issue 'tbl->buckets'
./include/net/inet_hashtables.h:166 inet_lhash2_bucket() warn: potential spectre issue 'h->lhash2'
./include/net/route.h:247 rt_tos2priority() warn: potential spectre issue 'ip_tos2prio'
./include/net/sctp/ulpevent.h:176 sctp_ulpevent_type_enabled() warn: potential spectre issue 'amask'
./include/net/udp.h:86 udp_hashslot() warn: potential spectre issue 'table->hash'
./include/rdma/ib_verbs.h:2679 rdma_protocol_ib() warn: potential spectre issue 'device->port_immutable'
./include/rdma/ib_verbs.h:2684 rdma_protocol_roce() warn: potential spectre issue 'device->port_immutable'
./include/rdma/ib_verbs.h:2901 rdma_cap_eth_ah() warn: potential spectre issue 'device->port_immutable'
ipc/sem.c:1096 count_semcnt() warn: potential spectre issue 'sma->sems'
ipc/sem.c:2084 do_semtimedop() warn: potential spectre issue 'sma->sems'
ipc/sem.c:388 sem_lock() warn: potential spectre issue 'sma->sems'
ipc/sem.c:641 perform_atomic_semop_slow() warn: potential spectre issue 'sma->sems'
ipc/sem.c:721 perform_atomic_semop() warn: potential spectre issue 'sma->sems'
kernel/bpf/arraymap.c:220 bpf_percpu_array_copy() warn: potential spectre issue 'array->pptrs'
kernel/bpf/arraymap.c:306 bpf_percpu_array_update() warn: potential spectre issue 'array->pptrs'
kernel/bpf/cgroup.c:106 compute_effective_progs() warn: potential spectre issue 'p->bpf.progs'
kernel/bpf/cgroup.c:79 hierarchy_allows_attach() warn: potential spectre issue 'p->bpf.progs'
kernel/events/ring_buffer.c:871 perf_mmap_to_page() warn: potential spectre issue 'rb->aux_pages'
kernel/sched/autogroup.c:230 proc_sched_autogroup_set_nice() warn: potential spectre issue 'sched_prio_to_weight'
kernel/sched/core.c:6921 cpu_weight_nice_write_s64() warn: potential spectre issue 'sched_prio_to_weight'
kernel/signal.c:3457 do_sigaction() warn: potential spectre issue 'p->sighand->action'
kernel/signal.c:65 sig_handler() warn: potential spectre issue 't->sighand->action'
lib/radix-tree.c:852 __radix_tree_create() warn: potential spectre issue 'node->slots'
net/atm/lec.c:702 lec_vcc_attach() warn: potential spectre issue 'dev_lec'
net/bluetooth/hci_event.c:4945 hci_le_adv_report_evt() warn: potential spectre issue 'ev->data'
net/bluetooth/hci_sock.c:116 hci_test_bit() warn: potential spectre issue 'addr'
net/bluetooth/mgmt.c:245 mgmt_status() warn: potential spectre issue 'mgmt_status_table'
net/core/dev.c:216 dev_index_hash() warn: potential spectre issue 'net->dev_index_head'
net/ieee802154/header_ops.c:208 ieee802154_hdr_sechdr_len() warn: potential spectre issue 'ieee802154_sechdr_lengths'
net/ipv4/fib_frontend.c:129 fib_get_table() warn: potential spectre issue 'net->ipv4.fib_table_hash'
net/ipv4/igmp.c:1343 ip_mc_hash_add() warn: potential spectre issue 'mc_hash'
net/ipv4/netfilter/nf_nat_h323.c:349 nat_h245() warn: potential spectre issue 'info->sig_port'
net/ipv4/netfilter/nf_nat_h323.c:441 nat_q931() warn: potential spectre issue 'info->sig_port'
net/ipv4/ping.c:79 ping_hashslot() warn: potential spectre issue 'table->hash'
net/ipv4/udp.c:1973 __udp4_lib_mcast_deliver() warn: potential spectre issue 'udptable->hash2'
net/ipv4/udp.c:478 __udp4_lib_lookup() warn: potential spectre issue 'udptable->hash2'
net/ipv6/ip6_fib.c:271 fib6_get_table() warn: potential spectre issue 'net->ipv6.fib_table_hash'
net/ipv6/sit.c:148 __ipip6_bucket() warn: potential spectre issue 'sitn->tunnels[prio]'
net/ipv6/udp.c:214 __udp6_lib_lookup() warn: potential spectre issue 'udptable->hash2'
net/ipv6/udp.c:696 __udp6_lib_mcast_deliver() warn: potential spectre issue 'udptable->hash2'
net/key/af_key.c:2844 pfkey_process() warn: potential spectre issue 'pfkey_funcs'
net/l2tp/l2tp_core.c:142 l2tp_session_id_hash_2() warn: potential spectre issue 'pn->l2tp_session_hlist'
net/l2tp/l2tp_core.c:155 l2tp_session_id_hash() warn: potential spectre issue 'tunnel->session_hlist'
net/netfilter/ipvs/ip_vs_ctl.c:2682 do_ip_vs_get_ctl() warn: potential spectre issue 'get_arglen'
net/netfilter/nf_nat_sip.c:371 nf_nat_sip_expect() warn: potential spectre issue 'ct->tuplehash'
net/netfilter/nfnetlink.c:193 nfnetlink_rcv_msg() warn: potential spectre issue 'ss->cb'
net/netfilter/nfnetlink.c:386 nfnetlink_rcv_batch() warn: potential spectre issue 'ss->cb'
net/netfilter/nfnetlink.c:72 lockdep_nfnl_is_held() warn: potential spectre issue 'table'
net/netfilter/nf_tables_api.c:1328 nft_chain_parse_hook() warn: potential spectre issue 'chain_type'
net/netfilter/nf_tables_api.c:1429 nf_tables_addchain() warn: potential spectre issue 'hook.type->hooks'
net/netfilter/nf_tables_api.c:459 __nf_tables_chain_type_lookup() warn: potential spectre issue 'chain_type'
net/netlabel/netlabel_unlabeled.c:223 netlbl_unlhsh_search_iface() warn: potential spectre issue '(null)'
net/nfc/digital_dep.c:450 digital_in_recv_atr_res() warn: potential spectre issue 'digital_rwt_map'
net/rds/info.c:209 rds_info_getsockopt() warn: potential spectre issue 'rds_info_funcs'
net/sched/cls_u32.c:1150 u32_change() warn: potential spectre issue 'ht->ht'
net/sctp/auth.c:537 sctp_auth_get_hmac() warn: potential spectre issue 'sctp_hmac_list'
net/sctp/auth.c:758 sctp_auth_calculate_hmac() warn: potential spectre issue 'asoc->ep->auth_hmacs'
net/sctp/outqueue.c:1294 sctp_outq_sack() warn: potential spectre issue 'frags'
net/sctp/sm_make_chunk.c:1588 sctp_chunk_assign_ssn() warn: potential spectre issue 'stream->out'
net/sctp/socket.c:6897 sctp_getsockopt_pr_assocstatus() warn: potential spectre issue 'asoc->abandoned_unsent'
net/sctp/socket.c:6899 sctp_getsockopt_pr_assocstatus() warn: potential spectre issue 'asoc->abandoned_sent'
net/sctp/socket.c:6965 sctp_getsockopt_pr_streamstatus() warn: potential spectre issue 'streamoute->abandoned_unsent'
net/sctp/socket.c:6967 sctp_getsockopt_pr_streamstatus() warn: potential spectre issue 'streamoute->abandoned_sent'
net/sctp/stream.c:561 sctp_process_strreset_outreq() warn: potential spectre issue 'asoc->strreset_result'
net/sctp/stream.c:648 sctp_process_strreset_inreq() warn: potential spectre issue 'asoc->strreset_result'
net/sctp/stream.c:727 sctp_process_strreset_tsnreq() warn: potential spectre issue 'asoc->strreset_result'
net/sctp/stream.c:823 sctp_process_strreset_addstrm_out() warn: potential spectre issue 'asoc->strreset_result'
net/sctp/stream.c:895 sctp_process_strreset_addstrm_in() warn: potential spectre issue 'asoc->strreset_result'
net/sctp/stream_sched_prio.c:204 sctp_sched_prio_get() warn: potential spectre issue 'stream->out'
net/tipc/name_table.c:342 tipc_service_find() warn: potential spectre issue 'nt->services'
net/tipc/name_table.c:366 tipc_nametbl_insert_publ() warn: potential spectre issue 'nt->services'
net/tipc/name_table.c:680 tipc_nametbl_subscribe() warn: potential spectre issue 'nt->services'
net/xfrm/xfrm_policy.c:3109 xfrm_migrate_policy_find() warn: potential spectre issue 'net->xfrm.policy_inexact'
net/xfrm/xfrm_policy.c:333 __get_hash_thresh() warn: potential spectre issue 'net->xfrm.policy_bydst'
net/xfrm/xfrm_policy.c:361 policy_hash_bysel() warn: potential spectre issue 'net->xfrm.policy_inexact'
security/apparmor/match.c:497 aa_dfa_next() warn: potential spectre issue 'next'
security/commoncap.c:1181 cap_task_prctl() warn: potential spectre issue '(old->cap_bset).cap'
security/commoncap.c:1267 cap_task_prctl() warn: potential spectre issue '(null)'
security/selinux/avc.c:276 avc_xperms_has_perm() warn: potential spectre issue 'xpd->allowed->p'
security/selinux/avc.c:279 avc_xperms_has_perm() warn: potential spectre issue 'xpd->auditallow->p'
security/selinux/avc.c:282 avc_xperms_has_perm() warn: potential spectre issue 'xpd->dontaudit->p'
security/tomoyo/file.c:169 tomoyo_audit_path_log() warn: potential spectre issue 'tomoyo_path_keyword'
security/tomoyo/file.c:564 tomoyo_path_permission() warn: potential spectre issue 'tomoyo_p2mac'
sound/core/control.c:1003 snd_ctl_elem_lock() warn: potential spectre issue 'kctl->vd'
sound/core/control.c:1031 snd_ctl_elem_unlock() warn: potential spectre issue 'kctl->vd'
sound/core/control.c:844 snd_ctl_elem_info() warn: potential spectre issue 'kctl->vd'
sound/core/control.c:891 snd_ctl_elem_read() warn: potential spectre issue 'kctl->vd'
sound/core/control.c:939 snd_ctl_elem_write() warn: potential spectre issue 'kctl->vd'
sound/core/seq/oss/seq_oss_event.c:293 note_on_event() warn: potential spectre issue 'dp->synths'
sound/core/seq/oss/seq_oss_event.c:353 note_off_event() warn: potential spectre issue 'dp->synths'
sound/core/seq/oss/seq_oss_synth.c:506 snd_seq_oss_synth_sysex() warn: potential spectre issue 'dp->synths'
sound/core/seq/oss/seq_oss_synth.c:580 snd_seq_oss_synth_ioctl() warn: potential spectre issue 'dp->synths'
sound/drivers/opl3/opl3_synth.c:476 snd_opl3_set_voice() warn: potential spectre issue 'snd_opl3_regmap'
sound/pci/asihpi/hpioctl.c:189 asihpi_hpi_ioctl() warn: potential spectre issue 'adapters'
sound/pci/hda/hda_local.h:467 get_wcaps() warn: potential spectre issue 'codec->wcaps'
