Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDXRqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:46:52 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:50395 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeDXRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:46:46 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "amit.karwar@redpinesignals.com" <amit.karwar@redpinesignals.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: rsi_91x: Failed to read status register / FIRMWARE Assert issues
Thread-Topic: rsi_91x: Failed to read status register / FIRMWARE Assert
 issues
Thread-Index: AQHT2/LucD19KYy3A0uE5NXCS0p3Nw==
Date: Tue, 24 Apr 2018 17:37:35 +0000
Message-ID: <1524591454.11868.7.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.59]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B37DC42A886EC43BC2415AC43DD03FE@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OHkuZQ020306

Hi Amitkumar,

I'm seeing quite a strange behavior of RedPine RS9113SB module.
I tried to use it as wifi hotspot, and sometimes I fail to connect to it.
Moreover after that failure RSI driver starts to flood me with following messages:
Issue 1:
--------------------->8--------------------
rsi_91x: rsi_handle_card_ready: card ready indication in invalid state 9.
rsi_91x: rsi_interrupt_handler: ==> FIRMWARE Assert <==
rsi_91x: rsi_interrupt_handler: Firmware Status is 0x79
rsi_91x: rsi_core_xmit: FSM state not open
rsi_91x: rsi_core_xmit: Failed to queue packet
rsi_91x: rsi_core_xmit: FSM state not open
rsi_91x: rsi_core_xmit: Failed to queue packet
--------------------->8--------------------

Sometimes messages in same situation can be different (Issue 2):
--------------------->8--------------------
rsi_91x: rsi_read_pkt: pkt from invalid queue: 2
rsi_91x: Failed to read the packet
rsi_91x: rsi_sdio_write_register_multiple: Synch Cmd53 write failed -16
rsi_91x: rsi_sdio_host_intf_write_pkt: Unable to write onto the card: -16
rsi_91x: rsi_send_data_pkt: Failed to write pkt
rsi_91x: rsi_sdio_check_buffer_status: Failed to read status register
rsi_91x: rsi_sdio_check_buffer_status: Failed to read status register
--------------------->8--------------------

NOTE:
I use vanilla Linux kernel v4.17-rc2
  rsi_91x: FW Version     : 1.6.1
  rsi_91x: Firmware file  : rsi/rs9113_wlan_bt_dual_mode.rps
Also these issues reproduce on vanilla v4.16 Linux kernel
  rsi_91x: FW Version     : 1.5.3
  rsi_91x: Firmware file  : rsi/rs9113_wlan_qspi.rps


Wifi hotspot is started with next commands:
--------------------->8--------------------
# echo 1 > /proc/sys/net/ipv4/ip_forward
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables -A FORWARD -i eth0 -o wlan0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
# hostapd -B /etc/hostapd.conf

# cat /etc/hostapd.conf
interface=wlan0
logger_syslog=-1
logger_syslog_level=2
logger_stdout=-1
logger_stdout_level=2
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
ssid=HSDK_wifi
hw_mode=g
channel=1
beacon_int=100
dtim_period=2
max_num_sta=255
rts_threshold=-1
fragm_threshold=-1
macaddr_acl=0
auth_algs=3
ignore_broadcast_ssid=0
wmm_enabled=1
wmm_ac_bk_cwmin=4
wmm_ac_bk_cwmax=10
wmm_ac_bk_aifs=7
wmm_ac_bk_txop_limit=0
wmm_ac_bk_acm=0
wmm_ac_be_aifs=3
wmm_ac_be_cwmin=4
wmm_ac_be_cwmax=10
wmm_ac_be_txop_limit=0
wmm_ac_be_acm=0
wmm_ac_vi_aifs=2
wmm_ac_vi_cwmin=3
wmm_ac_vi_cwmax=4
wmm_ac_vi_txop_limit=94
wmm_ac_vi_acm=0
wmm_ac_vo_aifs=2
wmm_ac_vo_cwmin=2
wmm_ac_vo_cwmax=3
wmm_ac_vo_txop_limit=47
wmm_ac_vo_acm=0
eapol_key_index_workaround=0
own_ip_addr=127.0.0.1
--------------------->8--------------------


I tried to reproduce this issues with extended RSI log enabled, this is log tail
for "Issue 2":
--------------------->8--------------------
rsi_91x: Pkt pending interrupt
rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 0, Msg Type:    8
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: Beacon event
rsi_91x: rsi_core_qos_processor: Queue number = 4
rsi_91x: rsi_send_beacon: Added to beacon queue
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: rsi_core_qos_processor: Queue number = 5
rsi_91x: rsi_interrupt_handler: Intr_status = 8 8 4
rsi_91x: Pkt pending interrupt
rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 0, Msg Type:    1
rsi_91x: rsi_handle_ta_confirm_type: Invalid TA confirm pkt received
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: rsi_core_qos_processor: Queue number = 4
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: rsi_core_qos_processor: Queue number = 4
rsi_91x: rsi_interrupt_handler: Intr_status = 8 8 4
rsi_91x: Pkt pending interrupt
rsi_91x: rsi_read_pkt: pkt from invalid queue: 2
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: Failed to read the packet
rsi_91x: rsi_core_qos_processor: Queue number = 255
rsi_91x: rsi_core_qos_processor: No More Pkt
rsi_91x: rsi_core_qos_processor: Queue number = 255
rsi_91x: rsi_core_qos_processor: No More Pkt
rsi_91x: rsi_core_xmit: ===> Scheduling TX thead <===
rsi_91x: rsi_core_qos_processor: Queue number = 1
rsi_91x: rsi_sdio_write_register_multiple: Synch Cmd53 write failed -16
rsi_91x: rsi_sdio_host_intf_write_pkt: Unable to write onto the card: -16
rsi_91x: rsi_sdio_host_intf_write_pkt: Successfully written onto card
rsi_91x: rsi_send_data_pkt: Failed to write pkt
rsi_91x: rsi_core_xmit: ===> Scheduling TX thead <===
rsi_91x: rsi_core_qos_processor: Queue number = 1
rsi_91x: rsi_sdio_check_buffer_status: Failed to read status register
rsi_91x: rsi_core_xmit: ===> Scheduling TX thead <===
rsi_91x: rsi_core_qos_processor: Queue number = 1
rsi_91x: rsi_sdio_check_buffer_status: Failed to read status register
--------------------->8--------------------

Any ideas what could be wrong?

-- 
 Eugeniy Paltsev
