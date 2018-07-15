Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B819E2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B819E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeGOHZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 03:25:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52519 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726005AbeGOHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 03:25:49 -0400
X-UUID: dd060c726d7f4acda1691a46af199c00-20180715
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2042122182; Sun, 15 Jul 2018 15:02:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Sun, 15 Jul
 2018 15:02:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 15 Jul 2018 15:02:49 +0800
Message-ID: <1531638169.3955.5.camel@mtkswgap22>
Subject: Re: [PATCH v5 4/7] Bluetooth: Add new quirk for non-persistent
 setup settings
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 15 Jul 2018 15:02:49 +0800
In-Reply-To: <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
         <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
         <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 18:34 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> > runs setup() after every open() and not just after the first open().
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > include/net/bluetooth/hci.h | 9 +++++++++
> > net/bluetooth/hci_core.c    | 3 ++-
> > 2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 73e48be..d3ec5b2a8 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -183,6 +183,15 @@ enum {
> > 	 * during the hdev->setup vendor callback.
> > 	 */
> > 	HCI_QUIRK_NON_PERSISTENT_DIAG,
> > +
> > +	/* When this quirk is set, setup() would be run after every
> > +	 * open() and not just after the first open().
> > +	 *
> > +	 * This quirk can be set before hci_register_dev is called or
> > +	 * during the hdev->setup vendor callback.
> > +	 *
> > +	 */
> > +	HCI_QUIRK_NON_PERSISTENT_SETUP,
> > };
> > 
> > /* HCI device flags */
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index f5c21004..0111280 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1396,7 +1396,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> > 	atomic_set(&hdev->cmd_cnt, 1);
> > 	set_bit(HCI_INIT, &hdev->flags);
> > 
> > -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> > +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> > +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> > 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> 
> can you include the extract of btmon on how the HCI_DEV_SETUP event shows up in the traces? I remember that I asked about something like that.
> 
> Regards
> 
> Marcel
> 

No, I cannot see any event about HCI_DEV_SETUP in btmon trace, the trace I posted as below is doing some rounds of power off and then on

Bluetooth monitor ver 5.50
= Note: Linux version 4.16.0-rc1+ (aarch64)                            0.804578
= Note: Bluetooth subsystem version 2.22                               0.804585
= New Index: 00:00:46:76:22:01 (Primary,UART,hci0)              [hci0] 0.804588
= Open Index: 00:00:46:76:22:01                                 [hci0] 0.804590
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)                [hci0] 0.804591
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.804594
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.804686
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 10.336163
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1       #1 [hci0] 10.336213
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #2 [hci0] 10.336401
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6                  #3 [hci0] 10.336643
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                           #4 [hci0] 10.337009
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 10.344683
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 10.344698
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 10.344729
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 24.468199
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 24.654235
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 24.654252
< HCI Command: Vendor (0x3f|0x006f) plen 255                #5 [hci0] 24.677385
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                           #6 [hci0] 24.677784
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255                #7 [hci0] 24.677833
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                           #8 [hci0] 24.678176
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255                #9 [hci0] 24.678209
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 3e 0d 24 00 46 10 00  .........>.$.F..
        af 58 10 80 a0 3e 2d 24 90 d5 03 a2 c9 aa c1 e2  .X...>-$........
        02 e9 fd dd 9e 3e 0d 24 90 3e 2d 29 74 84 20 d5  .....>.$.>-)t. .
        02 aa 41 e2 02 e9 fe dd 9e 3c 1d 49 08 46 00 20  ..A......<.I.F. 
        00 8c 28 58 00 00 20 b4 41 b6 40 04 30 80 40 a2  ..(X.. .A.@.0.@.
        89 9a 9a 92 41 46 30 20 00 a8 81 58 31 82 20 8c  ....AF0 ...X1. .
        08 4c 01 ff f3 3c 2d 49 08 46 10 20 00 b4 62 b6  .L...<-I.F. ..b.
        61 80 01 a0 91 a8 81 dd 9e ef f8 46 18 00 a0 96  a..........F....
        03 a8 09 46 08 00 a0 a0 42 f1 81 f1 01 54 10 80  ...F....B....T..
        02 c9 fb ec 08 dd 9e 92 00 3a 6f 9c bc ef fc 80  .........:o.....
        e0 90 10 49 ff ff eb 96 3b 49 ff ff e8 ec 04 3a  ...I....;I.....:
        6f 9c 84 dd 9e 3a 6f a4 bc ef fc 84 c0 81 00 50  o....:o........P
        90 ff fe d5 0e 38 04 18 00 84 2a 4c 00 c0 05 84  .....8....*L....
        0d 49 ff ff e4 38 04 18 00 9d b1 49 ff ff df e2  .I...8.....I....
        c9 e9 f2 ec 04 3a 6f a4 84 dd 9e 92 00 ef f8     .....:o........ 
> HCI Event: Vendor (0xff) plen 5                          #10 [hci0] 24.678552
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #11 [hci0] 24.678588
        01 01 fb 00 02 3c 2d 3a f7 44 01 c2 00 40 21 00  .....<-:.D...@!.
        16 46 18 00 00 04 30 80 42 46 08 00 a0 58 31 80  .F....0.BF...X1.
        80 14 30 80 42 a0 c3 44 4f ff cf f3 81 80 20 f3  ..0.B..DO..... .
        01 40 31 90 02 f3 81 f3 01 a8 c3 a8 8c ec 08 dd  .@1.............
        9e 92 00 54 10 80 0c 92 22 96 00 96 90 c1 6c 40  ...T....".....l@
        30 1c 09 44 00 00 22 4c 20 00 12 5c f1 00 23 e8  0..D.."L ..\..#.
        05 8e 11 4c 20 40 61 d5 08 8c 11 4c 20 00 0a 8c  ...L @a....L ...
        11 4c 20 40 5a d5 07 84 00 d5 42 84 00 d5 2a 84  .L @Z.....B...*.
        00 d5 14 84 42 4c 11 40 04 84 03 d5 0a 84 03 4c  ....BL.@.......L
        10 40 04 84 02 d5 05 56 00 80 01 5c 00 00 01 cb  .@.....V...\....
        05 44 21 40 00 40 00 08 04 84 42 4c 11 40 05 58  .D!@.@....BL.@.X
        00 00 0c d5 0c 84 43 4c 11 40 05 58 00 00 08 d5  ......CL.@.X....
        06 84 41 4c 11 40 04 58 00 00 04 cb 03 58 00 30  ..AL.@.X.....X.0
        00 84 42 4c 11 40 05 58 00 02 40 d5 0c 84 43 4c  ..BL.@.X..@...CL
        11 40 05 58 00 02 00 d5 06 84 41 4c 11 40 04 58  .@.X......AL.@.X
        00 00 40 cb 05 44 22 80 00 40 00 08 04 84 42     ..@..D"..@....B 
> HCI Event: Vendor (0xff) plen 5                          #12 [hci0] 24.678931
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #13 [hci0] 24.678963
        01 01 fb 00 02 4c 11 40 05 58 00 01 20 d5 0c 84  .....L.@.X.. ...
        43 4c 11 40 05 58 00 00 20 d5 06 84 41 4c 11 40  CL.@.X.. ...AL.@
        04 58 00 01 00 58 00 00 90 d5 02 84 00 dd 9e 92  .X...X..........
        00 3a 6f 98 bc 2e 34 db 4c 97 80 44 00 00 ff 96  .:o...4.L..D....
        88 4c 30 00 1d 80 23 3e 64 a7 f8 80 06 49 ff ff  .L0...#>d....I..
        7e 92 00 3c 2d 29 d5 80 20 80 06 dd 22 46 18 10  ~..<-).. ..."F..
        60 54 63 00 40 14 00 80 98 c6 09 46 08 10 60 04  `Tc.@......F..`.
        10 00 99 42 10 c0 08 14 10 00 99 3a 6f 98 84 dd  ...B.......:o...
        9e 44 40 00 22 54 00 00 0c 96 90 92 02 42 10 9c  .D@."T.......B..
        0b 4c 22 00 4e 5c f1 00 23 e8 06 44 50 00 11 4c  .L".N\..#..DP..L
        22 c0 85 d5 66 8c 91 4c 22 00 24 44 50 00 44 da  "...f..L".$DP.D.
        7d 9e 82 96 90 e6 42 e8 06 9c 9c b4 82 58 42 11  }.....B......XB.
        00 b6 82 9e 81 96 90 e6 42 e8 06 9c 9c b4 82 58  ........B......X
        42 00 10 b6 82 c9 0d 50 41 80 10 b4 a4 50 21 80  B......PA....P!.
        14 58 52 8f 00 b6 a4 b4 82 58 42 00 0e b6 82 9e  .XR......XB.....
        82 96 90 e6 42 e8 08 9c 9c b4 82 46 50 d0 00     ....B......FP.. 
> HCI Event: Vendor (0xff) plen 5                          #14 [hci0] 24.679305
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #15 [hci0] 24.679549
        01 01 fb 00 02 40 42 14 04 b6 82 9e 81 96 90 e6  .....@B.........
        42 e8 08 9c 9c b4 82 46 50 00 c0 40 42 14 04 b6  B......FP..@B...
        82 c9 09 50 21 80 10 b4 82 46 50 b0 a0 40 42 14  ...P!....FP..@B.
        04 b6 82 9e 82 96 90 e6 42 e8 07 50 21 80 0c b4  ........B..P!...
        82 58 42 09 00 b6 82 9e 81 96 90 e6 42 e8 07 50  .XB.........B..P
        21 80 08 b4 82 42 42 4c 08 b6 82 c9 0d 50 21 80  !....BBL.....P!.
        14 b4 82 50 11 80 10 58 42 07 00 b6 82 b4 41 58  ...P...XB.....AX
        21 00 06 b6 41 9e 42 96 48 e6 22 e8 07 50 11 80  !...A.B.H."..P..
        08 b4 41 58 21 05 00 b6 41 9e 01 96 00 e6 02 e8  ..AX!...A.......
        07 50 01 80 0c b4 20 58 10 80 04 b6 20 8c 68 b4  .P.... X.... .h.
        03 46 10 20 00 58 10 80 03 40 00 04 04 b6 03 dd  .F. .X...@......
        9e 92 00 3a 6f a4 bc ef d4 50 7f 80 04 97 80 54  ...:o....P.....T
        90 80 ff 54 81 00 ff 80 07 84 20 44 20 00 24 49  ...T...... D .$I
        fb c4 cc 54 03 00 0c c0 07 80 06 80 29 80 48 80  ...T........).H.
        67 49 ff ff 53 50 0f 80 04 a0 81 46 18 10 60 14  gI..SP.....F..`.
        20 80 32 a0 82 14 20 80 33 a0 83 14 20 80 34      .2... .3... .4 
> HCI Event: Vendor (0xff) plen 5                          #16 [hci0] 24.679926
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #17 [hci0] 24.679960
        01 01 fb 00 02 a0 84 14 20 80 35 a0 85 14 20 80  ........ .5... .
        36 a0 86 14 20 80 37 a0 87 14 20 80 38 04 00 00  6... .7... .8...
        08 14 00 80 39 ec 2c 3a 6f a4 84 dd 9e 3a 6f a0  ....9.,:o....:o.
        bc 97 80 3c 6f 36 d3 3c 3d 29 ce 80 06 54 80 80  ...<o6.<=)...T..
        ff 97 d0 dd 23 3c 1d 29 cf 80 06 dd 21 80 47 80  ....#<.)....!.G.
        06 80 28 49 ff ff b3 3c 1d 29 d3 80 06 dd 21 3c  ..(I...<.)....!<
        1d 29 d2 80 06 dd 21 3a 6f a0 84 dd 9e 3a 6f 98  .)....!:o....:o.
        bc 2e 24 a7 f5 40 60 20 09 96 00 97 b0 4c 20 00  ..$..@` .....L .
        0d 3e 04 a7 f5 3c 1d 36 d3 4c 10 00 07 2e 24 a7  .>...<.6.L....$.
        f9 80 26 49 ff ff cd 2e 14 a7 f9 3e 64 a7 f8 80  ..&I.......>d...
        06 49 ff fe ce 3a 6f 98 84 dd 9e 92 00 96 80 96  .I...:o.........
        14 c0 05 44 32 50 10 40 00 8c 02 54 31 00 02 c3  ...D2P.@...T1...
        07 44 41 a0 80 40 30 90 02 40 00 0c 04 54 31 00  .DA..@0..@...T1.
        04 c3 05 54 30 81 45 40 00 0c 04 54 31 00 08 c3  ...T0.E@...T1...
        05 54 30 82 2a 40 00 0c 04 54 31 00 10 c3 07 40  .T0.*@...T1....@
        30 d0 09 40 31 d0 08 40 00 0c 04 54 21 00 20     0..@1..@...T!.  
> HCI Event: Vendor (0xff) plen 5                          #18 [hci0] 24.680306
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #19 [hci0] 24.680336
        01 01 fb 00 02 c2 07 46 20 3f c0 40 10 88 02 40  .......F ?.@...@
        00 04 04 dd 9e 92 00 3b ff fc bc ef fc 84 68 96  .......;......h.
        00 96 49 4c 01 80 04 49 fb 48 7e ec 04 3b ff fc  ..IL...I.H~..;..
        84 dd 9e 3a 6f 98 bc 84 62 80 41 4c 01 c0 62 84  ...:o...b.AL..b.
        01 4c 10 40 3c 2e 04 eb c0 4c 00 80 38 46 18 10  .L.@<....L..8F..
        20 58 10 80 04 b4 01 58 00 00 20 b6 01 84 0a b4   X.....X.. .....
        41 58 21 00 10 b6 41 b4 41 58 21 00 01 b6 41 49  AX!...A.AX!...AI
        fb 22 48 46 18 10 21 58 10 81 04 b4 41 84 08 42  ."HF..!X....A..B
        21 48 08 b6 41 b4 41 42 21 4c 08 b6 41 49 fb 25  !H..A.AB!L..AI.%
        19 46 18 10 08 58 10 80 14 b4 41 84 0a 58 21 00  .F...X....A..X!.
        02 b6 41 b4 41 58 21 00 08 b6 41 b4 41 58 21 00  ..A.AX!...A.AX!.
        20 b6 41 49 fb 22 26 d5 26 46 08 10 20 58 00 00   .AI."&.&F.. X..
        04 b4 20 58 10 80 20 b6 20 b4 20 42 10 90 09 b6  .. X.. . . B....
        20 ca 0d 46 08 10 21 58 00 01 04 b4 20 42 10 c8   ..F..!X.... B..
        09 b6 20 b4 20 42 10 cc 09 b6 20 2e 04 ec 09 c8  .. . B.... .....
        0a 46 08 10 20 a0 41 58 10 a0 00 a8 41 d5 03     .F.. .AX....A.. 
> HCI Event: Vendor (0xff) plen 5                          #20 [hci0] 24.680692
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255               #21 [hci0] 24.680724
        01 01 fb 00 02 49 fb 2e 3c 3a 6f 98 84 dd 9e 92  .....I..<:o.....
        00 3a 6f aa bc ef e4 2e 64 e9 fc 96 d8 97 68 f1  .:o.....d.....h.
        84 f2 83 f3 81 97 e0 f5 85 83 80 c6 02 d5 0f f1  ................
        03 c9 10 c8 0f 44 10 00 20 44 20 00 12 46 30 00  .....D.. D ..F0.
        ae 58 31 88 cc 84 83 49 fb 4a fd 84 03 48 00 01  .X1....I.J...H..
        26 3c 6d 3b 35 84 01 4c 60 40 1a 44 10 00 f6 4c  &<m;5..L`@.D...L
        70 80 1e 80 07 44 12 00 00 49 fb 7c aa 84 00 44  p....D...I.|...D
        10 00 20 44 20 00 12 46 30 00 ae 58 31 88 cc 80  .. D ..F0..X1...
        86 49 fb 4a e0 80 06 48 00 01 09 84 06 4c 60 40  .I.J...H.....L`@
        07 44 10 00 f6 4c 70 80 03 d5 07 3e 6c e9 d4 00  .D...Lp....>l...
        93 00 06 4e 92 00 16 80 07 44 12 00 00 49 fb 7c  ...N.....D...I.|
        88 84 00 44 10 00 20 44 20 00 12 46 30 00 ae 58  ...D.. D ..F0..X
        31 88 cc 84 81 49 fb 4a be 84 01 48 00 00 e7 f0  1....I.J...H....
        04 f1 01 96 01 50 80 00 02 89 01 f0 82 40 14 00  .....P.......@..
        13 80 06 49 fb 79 37 81 00 c8 15 80 07 44 11 00  ...I.y7......D..
        00 49 fb 7c 66 80 08 44 10 00 20 44 20 00 12     .I.|f..D.. D .. 
> HCI Event: Vendor (0xff) plen 5                          #22 [hci0] 24.681096
        02 01 01 00 00                                   .....           

[ ... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255              #617 [hci0] 24.793891
        01 01 fb 00 02 32 00 00 00 3c 00 00 00 4e 4d 4c  .....2...<...NML
        4b 4a 49 48 47 2f 30 16 17 31 2e 18 15 46 19 14  KJIHG/0..1...F..
        2d 32 2c 33 00 19 e1 1d 40 1e 20 2c 8f 31 a0 36  -2,3....@. ,.1.6
        0d 5c 0e 5d 48 60 43 63 c6 67 6c 6b c7 75 88 79  .\.]H`Cc.glk.u.y
        81 0e 00 00 00 0b 01 08 04 0d 04 0e 05 0c 0a 0e  ................
        0e 0e 16 0e 1f 08 04 0d 04 0a 00 00 00 0b 01 08  ................
        04 0d 04 0e 05 0c 0a 0e 0e 0e 16 0e 1f 0f 1f 09  ................
        00 02 01 0f 00 04 00 03 00 24 25 26 25 27 27 26  .........$%&%''&
        26 25 26 0a 00 24 25 26 25 27 27 26 26 30 00 09  &%&..$%&%''&&0..
        00 15 3b 20 00 03 00 00 00 00 00 00 00 00 00 00  ..; ............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                         #618 [hci0] 24.794243
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #619 [hci0] 24.794274
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5b  ...............[
        46 44 42 5d 20 52 2e 53 20 52 32 38 20 30 78 25  FDB] R.S R28 0x%
        78 0a 00 5b 46 44 42 5d 20 52 2e 53 20 52 32 39  x..[FDB] R.S R29
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 2e 53   0x%x..[FDB] R.S
        20 52 33 30 20 30 78 25 78 0a 00 5b 46 44 42 5d   R30 0x%x..[FDB]
        20 52 2e 53 20 52 31 35 20 30 78 25 78 0a 00 5b   R.S R15 0x%x..[
        46 44 42 5d 20 52 2e 53 20 52 33 20 30 78 25 78  FDB] R.S R3 0x%x
        0a 00 00 5b 46 44 42 5d 20 52 2e 53 20 52 34 20  ...[FDB] R.S R4 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 2e 53  0x%x...[FDB] R.S
        20 52 35 20 30 78 25 78 0a 00 00 5b 46 44 42 5d   R5 0x%x...[FDB]
        20 52 2e 53 20 52 36 20 30 78 25 78 0a 00 00 5b   R.S R6 0x%x...[
        46 44 42 5d 20 52 2e 53 20 52 37 20 30 78 25     FDB] R.S R7 0x% 
> HCI Event: Vendor (0xff) plen 5                         #620 [hci0] 24.794626
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #621 [hci0] 24.794658
        01 01 fb 00 02 78 0a 00 00 5b 46 44 42 5d 20 52  .....x...[FDB] R
        2e 53 20 52 38 20 30 78 25 78 0a 00 00 5b 46 44  .S R8 0x%x...[FD
        42 5d 20 52 2e 53 20 52 39 20 30 78 25 78 0a 00  B] R.S R9 0x%x..
        00 5b 46 44 42 5d 20 52 2e 53 20 52 31 30 20 30  .[FDB] R.S R10 0
        78 25 78 0a 00 5b 46 44 42 5d 20 52 2e 53 20 52  x%x..[FDB] R.S R
        30 20 30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52  0 0x%x...[FDB] R
        2e 53 20 52 31 20 30 78 25 78 0a 00 00 5b 46 44  .S R1 0x%x...[FD
        42 5d 20 52 2e 53 20 52 32 20 30 78 25 78 0a 00  B] R.S R2 0x%x..
        00 5b 46 44 42 5d 20 52 2e 53 20 52 33 31 20 30  .[FDB] R.S R31 0
        78 25 78 0a 00 5b 46 44 42 5d 20 52 2e 53 20 50  x%x..[FDB] R.S P
        53 57 20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52  SW 0x%x..[FDB] R
        2e 53 20 50 43 20 30 78 25 78 0a 00 00 5b 46 44  .S PC 0x%x...[FD
        42 5d 20 44 2e 53 20 44 3a 30 78 25 78 20 25 25  B] D.S D:0x%x %%
        4c 45 20 25 25 4c 4f 4e 47 20 30 78 25 78 0a 00  LE %%LONG 0x%x..
        00 5b 46 44 42 5d 20 50 43 28 30 78 25 78 29 20  .[FDB] PC(0x%x) 
        3d 20 30 78 25 78 0a 00 00 5b 46 44 42 5d 20     = 0x%x...[FDB]  
> HCI Event: Vendor (0xff) plen 5                         #622 [hci0] 24.795008
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #623 [hci0] 24.795040
        01 01 fb 00 02 50 53 57 28 30 78 25 78 29 20 3d  .....PSW(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 32 38   0x%x..[FDB] R28
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 32 39 28 30 78 25 78 29 20 3d  FDB] R29(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 30   0x%x..[FDB] R30
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 31 35 28 30 78 25 78 29 20 3d  FDB] R15(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 28   0x%x..[FDB] R3(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 34 28 30 78 25 78 29 20 3d 20  FDB] R4(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 35 28  0x%x...[FDB] R5(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 36 28 30 78 25 78 29 20 3d 20  FDB] R6(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 37 28  0x%x...[FDB] R7(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 38 28 30 78 25 78 29 20 3d     FDB] R8(0x%x) = 
> HCI Event: Vendor (0xff) plen 5                         #624 [hci0] 24.795395
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #625 [hci0] 24.795453
        01 01 fb 00 02 20 30 78 25 78 0a 00 00 5b 46 44  ..... 0x%x...[FD
        42 5d 20 52 39 28 30 78 25 78 29 20 3d 20 30 78  B] R9(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 30 28 30  %x...[FDB] R10(0
        78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b 46 44  x%x) = 0x%x..[FD
        42 5d 20 52 30 28 30 78 25 78 29 20 3d 20 30 78  B] R0(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 28 30 78  %x...[FDB] R1(0x
        25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b 46 44  %x) = 0x%x...[FD
        42 5d 20 52 32 28 30 78 25 78 29 20 3d 20 30 78  B] R2(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 4e 75 6d 20 20  %x...[FDB] Num  
        20 20 20 54 79 70 65 20 20 20 20 20 20 45 6e 62     Type      Enb
        20 41 64 64 72 65 73 73 20 20 20 20 72 61 6e 67   Address    rang
        65 0a 00 00 00 5b 46 44 42 5d 20 20 20 25 64 20  e....[FDB]   %d 
        20 20 20 20 20 20 20 25 64 20 20 20 20 20 20 20         %d       
        20 25 64 20 30 78 25 78 20 20 20 20 30 78 25 78   %d 0x%x    0x%x
        0a 00 00 00 00 5b 46 44 42 5d 20 54 6f 6f 20 6d  .....[FDB] Too m
        61 6e 79 20 68 61 72 64 77 61 72 65 20 62 72     any hardware br 
> HCI Event: Vendor (0xff) plen 5                         #626 [hci0] 24.795800
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #627 [hci0] 24.795835
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                         #628 [hci0] 24.796188
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133              #629 [hci0] 24.796219
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                         #630 [hci0] 24.796469
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5                #631 [hci0] 24.796525
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                         #632 [hci0] 24.796643
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6                #633 [hci0] 24.796677
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                         #634 [hci0] 24.898972
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                 #635 [hci0] 24.899044
> HCI Event: Command Complete (0x0e) plen 4               #636 [hci0] 24.907197
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Support.. (0x04|0x0003) plen 0  #637 [hci0] 24.907230
> HCI Event: Command Complete (0x0e) plen 12              #638 [hci0] 24.907408
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Version.. (0x04|0x0001) plen 0  #639 [hci0] 24.907431
> HCI Event: Command Complete (0x0e) plen 12              #640 [hci0] 24.907686
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0          #641 [hci0] 24.907705
> HCI Event: Command Complete (0x0e) plen 10              #642 [hci0] 24.907860
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0      #643 [hci0] 24.907947
> HCI Event: Command Complete (0x0e) plen 11              #644 [hci0] 24.908085
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Device (0x03|0x0023) plen 0  #645 [hci0] 24.908104
> HCI Event: Command Complete (0x0e) plen 7               #646 [hci0] 24.908250
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0       #647 [hci0] 24.908269
> HCI Event: Command Complete (0x0e) plen 252             #648 [hci0] 24.908564
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0    #649 [hci0] 24.908584
> HCI Event: Command Complete (0x0e) plen 6               #650 [hci0] 24.908721
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Sup.. (0x03|0x0038) plen 0  #651 [hci0] 24.908739
> HCI Event: Command Complete (0x0e) plen 5               #652 [hci0] 24.908888
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0  #653 [hci0] 24.908907
> HCI Event: Command Complete (0x0e) plen 8               #654 [hci0] 24.909095
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1      #655 [hci0] 24.909115
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4               #656 [hci0] 24.909253
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection A.. (0x03|0x0016) plen 2  #657 [hci0] 24.909272
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4               #658 [hci0] 24.909440
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0   #659 [hci0] 24.909462
> HCI Event: Command Complete (0x0e) plen 7               #660 [hci0] 24.909622
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Supp.. (0x08|0x0003) plen 0  #661 [hci0] 24.909641
> HCI Event: Command Complete (0x0e) plen 12              #662 [hci0] 24.909837
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported... (0x08|0x001c) plen 0  #663 [hci0] 24.909858
> HCI Event: Command Complete (0x0e) plen 12              #664 [hci0] 24.910001
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Support.. (0x04|0x0002) plen 0  #665 [hci0] 24.910020
> HCI Event: Command Complete (0x0e) plen 68              #666 [hci0] 24.910197
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pairi.. (0x03|0x0056) plen 1  #667 [hci0] 24.910217
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4               #668 [hci0] 24.910353
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1    #669 [hci0] 24.910377
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4               #670 [hci0] 24.910530
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Respo.. (0x03|0x0058) plen 0  #671 [hci0] 24.910549
> HCI Event: Command Complete (0x0e) plen 5               #672 [hci0] 24.910703
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extende.. (0x04|0x0004) plen 1  #673 [hci0] 24.910724
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14              #674 [hci0] 24.910895
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8        #675 [hci0] 24.910943
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4               #676 [hci0] 24.911082
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7  #677 [hci0] 24.911100
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8               #678 [hci0] 24.911258
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Link.. (0x02|0x000f) plen 2  #679 [hci0] 24.911277
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4               #680 [hci0] 24.911434
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Act.. (0x03|0x001b) plen 0  #681 [hci0] 24.911462
> HCI Event: Command Complete (0x0e) plen 8               #682 [hci0] 24.911613
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0   #683 [hci0] 24.911633
> HCI Event: Command Complete (0x0e) plen 5               #684 [hci0] 24.911779
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8     #685 [hci0] 24.911799
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4               #686 [hci0] 24.911964
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Da.. (0x08|0x002f) plen 0  #687 [hci0] 24.911983
> HCI Event: Command Complete (0x0e) plen 12              #688 [hci0] 24.912158
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested... (0x08|0x0023) plen 0  #689 [hci0] 24.912177
> HCI Event: Command Complete (0x0e) plen 8               #690 [hci0] 24.912334
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Supp.. (0x03|0x006d) plen 2  #691 [hci0] 24.912352
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4               #692 [hci0] 24.912511
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extende.. (0x04|0x0004) plen 1  #693 [hci0] 24.912529
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14              #694 [hci0] 24.912724
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Link.. (0x03|0x0012) plen 7  #695 [hci0] 24.912768
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6               #696 [hci0] 24.912908
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pag.. (0x03|0x0063) plen 8  #697 [hci0] 24.912927
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4               #698 [hci0] 24.913092
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Support.. (0x04|0x000b) plen 0  #699 [hci0] 24.913112
> HCI Event: Command Complete (0x0e) plen 8               #700 [hci0] 24.913261
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizati.. (0x03|0x0077) plen 0  #701 [hci0] 24.913280
> HCI Event: Command Complete (0x0e) plen 11              #702 [hci0] 24.913448
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conne.. (0x03|0x007a) plen 1  #703 [hci0] 24.913466
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4               #704 [hci0] 24.913614
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggested.. (0x08|0x0024) plen 4  #705 [hci0] 24.913633
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4               #706 [hci0] 24.913800
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3    #707 [hci0] 24.913818
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4               #708 [hci0] 24.913974
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 24.914000
< HCI Command: LE Set Scan Respo.. (0x08|0x0009) plen 32  #709 [hci0] 24.914088
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4               #710 [hci0] 24.914247
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1     #711 [hci0] 24.914267
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4               #712 [hci0] 24.914469
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of Dev.. (0x03|0x0024) plen 3  #713 [hci0] 24.914488
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4               #714 [hci0] 24.914673
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 24.914688
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 24.914688
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248    #715 [hci0] 24.914713
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4               #716 [hci0] 24.915167
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended I.. (0x03|0x0052) plen 241  #717 [hci0] 24.915196
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4               #718 [hci0] 24.915580
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 24.915611
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 24.915620
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 26.296185
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1     #719 [hci0] 26.296231
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4               #720 [hci0] 26.296390
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6                #721 [hci0] 26.296437
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                         #722 [hci0] 26.296805
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 26.304031
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 26.304043
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 26.304073
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 28.000153
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 28.185698
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 28.185709
< HCI Command: Vendor (0x3f|0x006f) plen 255              #723 [hci0] 28.208853
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                         #724 [hci0] 28.209232
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255              #725 [hci0] 28.209283
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                         #726 [hci0] 28.209628
        02 01 01 00 00                                   .....           

[ .... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255             #1345 [hci0] 28.327258
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                        #1346 [hci0] 28.327600
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133             #1347 [hci0] 28.327633
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #1348 [hci0] 28.327884
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5               #1349 [hci0] 28.327945
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #1350 [hci0] 28.328058
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6               #1351 [hci0] 28.328098
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                        #1352 [hci0] 28.430396
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                #1353 [hci0] 28.430471
> HCI Event: Command Complete (0x0e) plen 4              #1354 [hci0] 28.438629
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x0003) plen 0  #1355 [hci0] 28.438663
> HCI Event: Command Complete (0x0e) plen 12             #1356 [hci0] 28.438828
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Versio.. (0x04|0x0001) plen 0  #1357 [hci0] 28.438850
> HCI Event: Command Complete (0x0e) plen 12             #1358 [hci0] 28.439109
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0         #1359 [hci0] 28.439136
> HCI Event: Command Complete (0x0e) plen 10             #1360 [hci0] 28.439287
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0     #1361 [hci0] 28.439346
> HCI Event: Command Complete (0x0e) plen 11             #1362 [hci0] 28.439471
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Dev.. (0x03|0x0023) plen 0  #1363 [hci0] 28.439492
> HCI Event: Command Complete (0x0e) plen 7              #1364 [hci0] 28.439646
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0      #1365 [hci0] 28.439666
> HCI Event: Command Complete (0x0e) plen 252            #1366 [hci0] 28.439962
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0   #1367 [hci0] 28.439984
> HCI Event: Command Complete (0x0e) plen 6              #1368 [hci0] 28.440116
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Su.. (0x03|0x0038) plen 0  #1369 [hci0] 28.440137
> HCI Event: Command Complete (0x0e) plen 5              #1370 [hci0] 28.440285
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC... (0x03|0x0039) plen 0  #1371 [hci0] 28.440335
> HCI Event: Command Complete (0x0e) plen 8              #1372 [hci0] 28.440474
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1     #1373 [hci0] 28.440495
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #1374 [hci0] 28.440644
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection... (0x03|0x0016) plen 2  #1375 [hci0] 28.440669
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4              #1376 [hci0] 28.440824
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0  #1377 [hci0] 28.440844
> HCI Event: Command Complete (0x0e) plen 7              #1378 [hci0] 28.441008
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Sup.. (0x08|0x0003) plen 0  #1379 [hci0] 28.441030
> HCI Event: Command Complete (0x0e) plen 12             #1380 [hci0] 28.441200
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported.. (0x08|0x001c) plen 0  #1381 [hci0] 28.441225
> HCI Event: Command Complete (0x0e) plen 12             #1382 [hci0] 28.441381
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Suppor.. (0x04|0x0002) plen 0  #1383 [hci0] 28.441402
> HCI Event: Command Complete (0x0e) plen 68             #1384 [hci0] 28.441578
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pair.. (0x03|0x0056) plen 1  #1385 [hci0] 28.441598
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #1386 [hci0] 28.441740
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1   #1387 [hci0] 28.441785
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #1388 [hci0] 28.441938
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Resp.. (0x03|0x0058) plen 0  #1389 [hci0] 28.441959
> HCI Event: Command Complete (0x0e) plen 5              #1390 [hci0] 28.442114
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #1391 [hci0] 28.442136
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14             #1392 [hci0] 28.442290
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8       #1393 [hci0] 28.442339
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4              #1394 [hci0] 28.442475
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link... (0x03|0x000d) plen 7  #1395 [hci0] 28.442496
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8              #1396 [hci0] 28.442658
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Lin.. (0x02|0x000f) plen 2  #1397 [hci0] 28.442680
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4              #1398 [hci0] 28.442830
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Ac.. (0x03|0x001b) plen 0  #1399 [hci0] 28.442850
> HCI Event: Command Complete (0x0e) plen 8              #1400 [hci0] 28.443011
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0  #1401 [hci0] 28.443032
> HCI Event: Command Complete (0x0e) plen 5              #1402 [hci0] 28.443177
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8    #1403 [hci0] 28.443231
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4              #1404 [hci0] 28.443369
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum D.. (0x08|0x002f) plen 0  #1405 [hci0] 28.443390
> HCI Event: Command Complete (0x0e) plen 12             #1406 [hci0] 28.443568
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested.. (0x08|0x0023) plen 0  #1407 [hci0] 28.443593
> HCI Event: Command Complete (0x0e) plen 8              #1408 [hci0] 28.443734
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Sup.. (0x03|0x006d) plen 2  #1409 [hci0] 28.443756
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #1410 [hci0] 28.443911
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #1411 [hci0] 28.443932
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14             #1412 [hci0] 28.444086
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Lin.. (0x03|0x0012) plen 7  #1413 [hci0] 28.444130
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6              #1414 [hci0] 28.444275
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pa.. (0x03|0x0063) plen 8  #1415 [hci0] 28.444297
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4              #1416 [hci0] 28.444451
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x000b) plen 0  #1417 [hci0] 28.444471
> HCI Event: Command Complete (0x0e) plen 8              #1418 [hci0] 28.444626
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizat.. (0x03|0x0077) plen 0  #1419 [hci0] 28.444681
> HCI Event: Command Complete (0x0e) plen 11             #1420 [hci0] 28.444831
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conn.. (0x03|0x007a) plen 1  #1421 [hci0] 28.444852
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #1422 [hci0] 28.444995
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggeste.. (0x08|0x0024) plen 4  #1423 [hci0] 28.445019
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4              #1424 [hci0] 28.445180
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3   #1425 [hci0] 28.445201
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #1426 [hci0] 28.445356
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 28.445381
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #1427 [hci0] 28.445449
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4              #1428 [hci0] 28.445611
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #1429 [hci0] 28.445632
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #1430 [hci0] 28.445831
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of De.. (0x03|0x0024) plen 3  #1431 [hci0] 28.445852
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #1432 [hci0] 28.446004
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 28.446018
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 28.446018
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248   #1433 [hci0] 28.446045
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4              #1434 [hci0] 28.446432
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended... (0x03|0x0052) plen 241  #1435 [hci0] 28.446459
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4              #1436 [hci0] 28.446831
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 28.446865
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 28.446873
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 30.468165
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #1437 [hci0] 30.468210
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #1438 [hci0] 30.468529
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6               #1439 [hci0] 30.468583
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                        #1440 [hci0] 30.468937
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 30.475952
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 30.475968
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 30.476000
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 32.032162
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 32.219576
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 32.219587
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1441 [hci0] 32.242898
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #1442 [hci0] 32.243283
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1443 [hci0] 32.243392
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #1444 [hci0] 32.243968
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1445 [hci0] 32.244015
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 3e 0d 24 00 46 10 00  .........>.$.F..
        af 58 10 80 a0 3e 2d 24 90 d5 03 a2 c9 aa c1 e2  .X...>-$........
        02 e9 fd dd 9e 3e 0d 24 90 3e 2d 29 74 84 20 d5  .....>.$.>-)t. .
        02 aa 41 e2 02 e9 fe dd 9e 3c 1d 49 08 46 00 20  ..A......<.I.F. 
        00 8c 28 58 00 00 20 b4 41 b6 40 04 30 80 40 a2  ..(X.. .A.@.0.@.
        89 9a 9a 92 41 46 30 20 00 a8 81 58 31 82 20 8c  ....AF0 ...X1. .
        08 4c 01 ff f3 3c 2d 49 08 46 10 20 00 b4 62 b6  .L...<-I.F. ..b.
        61 80 01 a0 91 a8 81 dd 9e ef f8 46 18 00 a0 96  a..........F....
        03 a8 09 46 08 00 a0 a0 42 f1 81 f1 01 54 10 80  ...F....B....T..
        02 c9 fb ec 08 dd 9e 92 00 3a 6f 9c bc ef fc 80  .........:o.....
        e0 90 10 49 ff ff eb 96 3b 49 ff ff e8 ec 04 3a  ...I....;I.....:
        6f 9c 84 dd 9e 3a 6f a4 bc ef fc 84 c0 81 00 50  o....:o........P
        90 ff fe d5 0e 38 04 18 00 84 2a 4c 00 c0 05 84  .....8....*L....
        0d 49 ff ff e4 38 04 18 00 9d b1 49 ff ff df e2  .I...8.....I....
        c9 e9 f2 ec 04 3a 6f a4 84 dd 9e 92 00 ef f8     .....:o........ 
> HCI Event: Vendor (0xff) plen 5                        #1446 [hci0] 32.244360
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1447 [hci0] 32.244397
        01 01 fb 00 02 3c 2d 3a f7 44 01 c2 00 40 21 00  .....<-:.D...@!.
        16 46 18 00 00 04 30 80 42 46 08 00 a0 58 31 80  .F....0.BF...X1.
        80 14 30 80 42 a0 c3 44 4f ff cf f3 81 80 20 f3  ..0.B..DO..... .
        01 40 31 90 02 f3 81 f3 01 a8 c3 a8 8c ec 08 dd  .@1.............
        9e 92 00 54 10 80 0c 92 22 96 00 96 90 c1 6c 40  ...T....".....l@
        30 1c 09 44 00 00 22 4c 20 00 12 5c f1 00 23 e8  0..D.."L ..\..#.
        05 8e 11 4c 20 40 61 d5 08 8c 11 4c 20 00 0a 8c  ...L @a....L ...
        11 4c 20 40 5a d5 07 84 00 d5 42 84 00 d5 2a 84  .L @Z.....B...*.
        00 d5 14 84 42 4c 11 40 04 84 03 d5 0a 84 03 4c  ....BL.@.......L
        10 40 04 84 02 d5 05 56 00 80 01 5c 00 00 01 cb  .@.....V...\....
        05 44 21 40 00 40 00 08 04 84 42 4c 11 40 05 58  .D!@.@....BL.@.X
        00 00 0c d5 0c 84 43 4c 11 40 05 58 00 00 08 d5  ......CL.@.X....
        06 84 41 4c 11 40 04 58 00 00 04 cb 03 58 00 30  ..AL.@.X.....X.0
        00 84 42 4c 11 40 05 58 00 02 40 d5 0c 84 43 4c  ..BL.@.X..@...CL
        11 40 05 58 00 02 00 d5 06 84 41 4c 11 40 04 58  .@.X......AL.@.X
        00 00 40 cb 05 44 22 80 00 40 00 08 04 84 42     ..@..D"..@....B 
> HCI Event: Vendor (0xff) plen 5                        #1448 [hci0] 32.244742
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1449 [hci0] 32.244776
        01 01 fb 00 02 4c 11 40 05 58 00 01 20 d5 0c 84  .....L.@.X.. ...
        43 4c 11 40 05 58 00 00 20 d5 06 84 41 4c 11 40  CL.@.X.. ...AL.@
        04 58 00 01 00 58 00 00 90 d5 02 84 00 dd 9e 92  .X...X..........
        00 3a 6f 98 bc 2e 34 db 4c 97 80 44 00 00 ff 96  .:o...4.L..D....
        88 4c 30 00 1d 80 23 3e 64 a7 f8 80 06 49 ff ff  .L0...#>d....I..
        7e 92 00 3c 2d 29 d5 80 20 80 06 dd 22 46 18 10  ~..<-).. ..."F..
        60 54 63 00 40 14 00 80 98 c6 09 46 08 10 60 04  `Tc.@......F..`.
        10 00 99 42 10 c0 08 14 10 00 99 3a 6f 98 84 dd  ...B.......:o...
        9e 44 40 00 22 54 00 00 0c 96 90 92 02 42 10 9c  .D@."T.......B..
        0b 4c 22 00 4e 5c f1 00 23 e8 06 44 50 00 11 4c  .L".N\..#..DP..L
        22 c0 85 d5 66 8c 91 4c 22 00 24 44 50 00 44 da  "...f..L".$DP.D.
        7d 9e 82 96 90 e6 42 e8 06 9c 9c b4 82 58 42 11  }.....B......XB.
        00 b6 82 9e 81 96 90 e6 42 e8 06 9c 9c b4 82 58  ........B......X
        42 00 10 b6 82 c9 0d 50 41 80 10 b4 a4 50 21 80  B......PA....P!.
        14 58 52 8f 00 b6 a4 b4 82 58 42 00 0e b6 82 9e  .XR......XB.....
        82 96 90 e6 42 e8 08 9c 9c b4 82 46 50 d0 00     ....B......FP.. 
> HCI Event: Vendor (0xff) plen 5                        #1450 [hci0] 32.245117
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #1451 [hci0] 32.245153
        01 01 fb 00 02 40 42 14 04 b6 82 9e 81 96 90 e6  .....@B.........
        42 e8 08 9c 9c b4 82 46 50 00 c0 40 42 14 04 b6  B......FP..@B...
        82 c9 09 50 21 80 10 b4 82 46 50 b0 a0 40 42 14  ...P!....FP..@B.
        04 b6 82 9e 82 96 90 e6 42 e8 07 50 21 80 0c b4  ........B..P!...
        82 58 42 09 00 b6 82 9e 81 96 90 e6 42 e8 07 50  .XB.........B..P
        21 80 08 b4 82 42 42 4c 08 b6 82 c9 0d 50 21 80  !....BBL.....P!.
        14 b4 82 50 11 80 10 58 42 07 00 b6 82 b4 41 58  ...P...XB.....AX
        21 00 06 b6 41 9e 42 96 48 e6 22 e8 07 50 11 80  !...A.B.H."..P..
        08 b4 41 58 21 05 00 b6 41 9e 01 96 00 e6 02 e8  ..AX!...A.......
        07 50 01 80 0c b4 20 58 10 80 04 b6 20 8c 68 b4  .P.... X.... .h.
        03 46 10 20 00 58 10 80 03 40 00 04 04 b6 03 dd  .F. .X...@......
        9e 92 00 3a 6f a4 bc ef d4 50 7f 80 04 97 80 54  ...:o....P.....T
        90 80 ff 54 81 00 ff 80 07 84 20 44 20 00 24 49  ...T...... D .$I
        fb c4 cc 54 03 00 0c c0 07 80 06 80 29 80 48 80  ...T........).H.
        67 49 ff ff 53 50 0f 80 04 a0 81 46 18 10 60 14  gI..SP.....F..`.
        20 80 32 a0 82 14 20 80 33 a0 83 14 20 80 34      .2... .3... .4 
> HCI Event: Vendor (0xff) plen 5                        #1452 [hci0] 32.245494
        02 01 01 00 00                                   .....           

[ ... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255             #2063 [hci0] 32.361348
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                        #2064 [hci0] 32.361699
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133             #2065 [hci0] 32.361733
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #2066 [hci0] 32.361984
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5               #2067 [hci0] 32.362033
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #2068 [hci0] 32.362152
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6               #2069 [hci0] 32.362185
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                        #2070 [hci0] 32.464495
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                #2071 [hci0] 32.464567
> HCI Event: Command Complete (0x0e) plen 4              #2072 [hci0] 32.472717
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x0003) plen 0  #2073 [hci0] 32.472752
> HCI Event: Command Complete (0x0e) plen 12             #2074 [hci0] 32.472919
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Versio.. (0x04|0x0001) plen 0  #2075 [hci0] 32.472944
> HCI Event: Command Complete (0x0e) plen 12             #2076 [hci0] 32.473206
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0         #2077 [hci0] 32.473225
> HCI Event: Command Complete (0x0e) plen 10             #2078 [hci0] 32.473382
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0     #2079 [hci0] 32.473436
> HCI Event: Command Complete (0x0e) plen 11             #2080 [hci0] 32.473569
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Dev.. (0x03|0x0023) plen 0  #2081 [hci0] 32.473588
> HCI Event: Command Complete (0x0e) plen 7              #2082 [hci0] 32.473738
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0      #2083 [hci0] 32.473756
> HCI Event: Command Complete (0x0e) plen 252            #2084 [hci0] 32.474073
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0   #2085 [hci0] 32.474092
> HCI Event: Command Complete (0x0e) plen 6              #2086 [hci0] 32.474229
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Su.. (0x03|0x0038) plen 0  #2087 [hci0] 32.474248
> HCI Event: Command Complete (0x0e) plen 5              #2088 [hci0] 32.474402
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC... (0x03|0x0039) plen 0  #2089 [hci0] 32.474421
> HCI Event: Command Complete (0x0e) plen 8              #2090 [hci0] 32.474578
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1     #2091 [hci0] 32.474596
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #2092 [hci0] 32.474752
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection... (0x03|0x0016) plen 2  #2093 [hci0] 32.474770
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4              #2094 [hci0] 32.474936
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0  #2095 [hci0] 32.474955
> HCI Event: Command Complete (0x0e) plen 7              #2096 [hci0] 32.475116
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Sup.. (0x08|0x0003) plen 0  #2097 [hci0] 32.475136
> HCI Event: Command Complete (0x0e) plen 12             #2098 [hci0] 32.475338
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported.. (0x08|0x001c) plen 0  #2099 [hci0] 32.475359
> HCI Event: Command Complete (0x0e) plen 12             #2100 [hci0] 32.475513
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Suppor.. (0x04|0x0002) plen 0  #2101 [hci0] 32.475532
> HCI Event: Command Complete (0x0e) plen 68             #2102 [hci0] 32.475706
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pair.. (0x03|0x0056) plen 1  #2103 [hci0] 32.475724
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #2104 [hci0] 32.475863
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1   #2105 [hci0] 32.475886
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #2106 [hci0] 32.476035
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Resp.. (0x03|0x0058) plen 0  #2107 [hci0] 32.476069
> HCI Event: Command Complete (0x0e) plen 5              #2108 [hci0] 32.476214
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #2109 [hci0] 32.476233
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14             #2110 [hci0] 32.476397
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8       #2111 [hci0] 32.476448
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4              #2112 [hci0] 32.476588
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link... (0x03|0x000d) plen 7  #2113 [hci0] 32.476607
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8              #2114 [hci0] 32.476766
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Lin.. (0x02|0x000f) plen 2  #2115 [hci0] 32.476785
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4              #2116 [hci0] 32.476938
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Ac.. (0x03|0x001b) plen 0  #2117 [hci0] 32.476957
> HCI Event: Command Complete (0x0e) plen 8              #2118 [hci0] 32.477114
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0  #2119 [hci0] 32.477133
> HCI Event: Command Complete (0x0e) plen 5              #2120 [hci0] 32.477286
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8    #2121 [hci0] 32.477304
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4              #2122 [hci0] 32.477472
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum D.. (0x08|0x002f) plen 0  #2123 [hci0] 32.477491
> HCI Event: Command Complete (0x0e) plen 12             #2124 [hci0] 32.477665
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested.. (0x08|0x0023) plen 0  #2125 [hci0] 32.477685
> HCI Event: Command Complete (0x0e) plen 8              #2126 [hci0] 32.477836
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Sup.. (0x03|0x006d) plen 2  #2127 [hci0] 32.477855
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2128 [hci0] 32.478016
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #2129 [hci0] 32.478035
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14             #2130 [hci0] 32.478188
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Lin.. (0x03|0x0012) plen 7  #2131 [hci0] 32.478231
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6              #2132 [hci0] 32.478377
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pa.. (0x03|0x0063) plen 8  #2133 [hci0] 32.478396
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4              #2134 [hci0] 32.478553
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x000b) plen 0  #2135 [hci0] 32.478574
> HCI Event: Command Complete (0x0e) plen 8              #2136 [hci0] 32.478728
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizat.. (0x03|0x0077) plen 0  #2137 [hci0] 32.478745
> HCI Event: Command Complete (0x0e) plen 11             #2138 [hci0] 32.478916
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conn.. (0x03|0x007a) plen 1  #2139 [hci0] 32.478933
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #2140 [hci0] 32.479085
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggeste.. (0x08|0x0024) plen 4  #2141 [hci0] 32.479105
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4              #2142 [hci0] 32.479268
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3   #2143 [hci0] 32.479287
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2144 [hci0] 32.479446
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 32.479478
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #2145 [hci0] 32.479547
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4              #2146 [hci0] 32.479706
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #2147 [hci0] 32.479724
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #2148 [hci0] 32.479931
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of De.. (0x03|0x0024) plen 3  #2149 [hci0] 32.479949
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2150 [hci0] 32.480103
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 32.480120
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 32.480120
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248   #2151 [hci0] 32.480146
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4              #2152 [hci0] 32.480622
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended... (0x03|0x0052) plen 241  #2153 [hci0] 32.480644
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4              #2154 [hci0] 32.480999
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 32.481033
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 32.481043
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 33.836170
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #2155 [hci0] 33.836214
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #2156 [hci0] 33.836371
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6               #2157 [hci0] 33.836417
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                        #2158 [hci0] 33.836771
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 33.843966
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 33.843979
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 33.844009
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 35.612173
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 35.799549
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 35.799566
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2159 [hci0] 35.822699
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #2160 [hci0] 35.823088
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2161 [hci0] 35.823129
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #2162 [hci0] 35.823544
        02 01 01 00 00                                   .....           

[ ... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255             #2777 [hci0] 35.939265
        01 01 fb 00 02 50 53 57 28 30 78 25 78 29 20 3d  .....PSW(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 32 38   0x%x..[FDB] R28
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 32 39 28 30 78 25 78 29 20 3d  FDB] R29(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 30   0x%x..[FDB] R30
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 31 35 28 30 78 25 78 29 20 3d  FDB] R15(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 28   0x%x..[FDB] R3(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 34 28 30 78 25 78 29 20 3d 20  FDB] R4(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 35 28  0x%x...[FDB] R5(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 36 28 30 78 25 78 29 20 3d 20  FDB] R6(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 37 28  0x%x...[FDB] R7(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 38 28 30 78 25 78 29 20 3d     FDB] R8(0x%x) = 
> HCI Event: Vendor (0xff) plen 5                        #2778 [hci0] 35.939613
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2779 [hci0] 35.939647
        01 01 fb 00 02 20 30 78 25 78 0a 00 00 5b 46 44  ..... 0x%x...[FD
        42 5d 20 52 39 28 30 78 25 78 29 20 3d 20 30 78  B] R9(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 30 28 30  %x...[FDB] R10(0
        78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b 46 44  x%x) = 0x%x..[FD
        42 5d 20 52 30 28 30 78 25 78 29 20 3d 20 30 78  B] R0(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 28 30 78  %x...[FDB] R1(0x
        25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b 46 44  %x) = 0x%x...[FD
        42 5d 20 52 32 28 30 78 25 78 29 20 3d 20 30 78  B] R2(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 4e 75 6d 20 20  %x...[FDB] Num  
        20 20 20 54 79 70 65 20 20 20 20 20 20 45 6e 62     Type      Enb
        20 41 64 64 72 65 73 73 20 20 20 20 72 61 6e 67   Address    rang
        65 0a 00 00 00 5b 46 44 42 5d 20 20 20 25 64 20  e....[FDB]   %d 
        20 20 20 20 20 20 20 25 64 20 20 20 20 20 20 20         %d       
        20 25 64 20 30 78 25 78 20 20 20 20 30 78 25 78   %d 0x%x    0x%x
        0a 00 00 00 00 5b 46 44 42 5d 20 54 6f 6f 20 6d  .....[FDB] Too m
        61 6e 79 20 68 61 72 64 77 61 72 65 20 62 72     any hardware br 
> HCI Event: Vendor (0xff) plen 5                        #2780 [hci0] 35.939995
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2781 [hci0] 35.940028
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                        #2782 [hci0] 35.940373
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133             #2783 [hci0] 35.940405
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #2784 [hci0] 35.940659
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5               #2785 [hci0] 35.940715
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #2786 [hci0] 35.940833
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6               #2787 [hci0] 35.940906
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                        #2788 [hci0] 36.043127
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                #2789 [hci0] 36.043203
> HCI Event: Command Complete (0x0e) plen 4              #2790 [hci0] 36.051508
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x0003) plen 0  #2791 [hci0] 36.051544
> HCI Event: Command Complete (0x0e) plen 12             #2792 [hci0] 36.051714
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Versio.. (0x04|0x0001) plen 0  #2793 [hci0] 36.051736
> HCI Event: Command Complete (0x0e) plen 12             #2794 [hci0] 36.051987
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0         #2795 [hci0] 36.052007
> HCI Event: Command Complete (0x0e) plen 10             #2796 [hci0] 36.052172
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0     #2797 [hci0] 36.052228
> HCI Event: Command Complete (0x0e) plen 11             #2798 [hci0] 36.052363
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Dev.. (0x03|0x0023) plen 0  #2799 [hci0] 36.052383
> HCI Event: Command Complete (0x0e) plen 7              #2800 [hci0] 36.052528
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0      #2801 [hci0] 36.052550
> HCI Event: Command Complete (0x0e) plen 252            #2802 [hci0] 36.052839
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0   #2803 [hci0] 36.052860
> HCI Event: Command Complete (0x0e) plen 6              #2804 [hci0] 36.052993
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Su.. (0x03|0x0038) plen 0  #2805 [hci0] 36.053016
> HCI Event: Command Complete (0x0e) plen 5              #2806 [hci0] 36.053161
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC... (0x03|0x0039) plen 0  #2807 [hci0] 36.053182
> HCI Event: Command Complete (0x0e) plen 8              #2808 [hci0] 36.053341
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1     #2809 [hci0] 36.053361
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #2810 [hci0] 36.053512
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection... (0x03|0x0016) plen 2  #2811 [hci0] 36.053540
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4              #2812 [hci0] 36.053699
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0  #2813 [hci0] 36.053730
> HCI Event: Command Complete (0x0e) plen 7              #2814 [hci0] 36.053887
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Sup.. (0x08|0x0003) plen 0  #2815 [hci0] 36.053909
> HCI Event: Command Complete (0x0e) plen 12             #2816 [hci0] 36.054067
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported.. (0x08|0x001c) plen 0  #2817 [hci0] 36.054098
> HCI Event: Command Complete (0x0e) plen 12             #2818 [hci0] 36.054250
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Suppor.. (0x04|0x0002) plen 0  #2819 [hci0] 36.054274
> HCI Event: Command Complete (0x0e) plen 68             #2820 [hci0] 36.054445
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pair.. (0x03|0x0056) plen 1  #2821 [hci0] 36.054468
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #2822 [hci0] 36.054606
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1   #2823 [hci0] 36.054629
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #2824 [hci0] 36.054781
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Resp.. (0x03|0x0058) plen 0  #2825 [hci0] 36.054838
> HCI Event: Command Complete (0x0e) plen 5              #2826 [hci0] 36.054968
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #2827 [hci0] 36.054989
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14             #2828 [hci0] 36.055154
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8       #2829 [hci0] 36.055205
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4              #2830 [hci0] 36.055351
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link... (0x03|0x000d) plen 7  #2831 [hci0] 36.055370
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8              #2832 [hci0] 36.055533
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Lin.. (0x02|0x000f) plen 2  #2833 [hci0] 36.055552
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4              #2834 [hci0] 36.055706
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Ac.. (0x03|0x001b) plen 0  #2835 [hci0] 36.055725
> HCI Event: Command Complete (0x0e) plen 8              #2836 [hci0] 36.055891
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0  #2837 [hci0] 36.055910
> HCI Event: Command Complete (0x0e) plen 5              #2838 [hci0] 36.056054
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8    #2839 [hci0] 36.056072
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4              #2840 [hci0] 36.056244
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum D.. (0x08|0x002f) plen 0  #2841 [hci0] 36.056264
> HCI Event: Command Complete (0x0e) plen 12             #2842 [hci0] 36.056436
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested.. (0x08|0x0023) plen 0  #2843 [hci0] 36.056455
> HCI Event: Command Complete (0x0e) plen 8              #2844 [hci0] 36.056608
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Sup.. (0x03|0x006d) plen 2  #2845 [hci0] 36.056628
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2846 [hci0] 36.056785
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #2847 [hci0] 36.056806
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14             #2848 [hci0] 36.056960
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Lin.. (0x03|0x0012) plen 7  #2849 [hci0] 36.057007
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6              #2850 [hci0] 36.057155
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pa.. (0x03|0x0063) plen 8  #2851 [hci0] 36.057174
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4              #2852 [hci0] 36.057344
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x000b) plen 0  #2853 [hci0] 36.057363
> HCI Event: Command Complete (0x0e) plen 8              #2854 [hci0] 36.057513
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizat.. (0x03|0x0077) plen 0  #2855 [hci0] 36.057531
> HCI Event: Command Complete (0x0e) plen 11             #2856 [hci0] 36.057727
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conn.. (0x03|0x007a) plen 1  #2857 [hci0] 36.057747
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #2858 [hci0] 36.057883
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggeste.. (0x08|0x0024) plen 4  #2859 [hci0] 36.057904
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4              #2860 [hci0] 36.058077
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3   #2861 [hci0] 36.058095
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2862 [hci0] 36.058241
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 36.058272
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #2863 [hci0] 36.058342
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4              #2864 [hci0] 36.058502
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #2865 [hci0] 36.058525
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #2866 [hci0] 36.058723
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of De.. (0x03|0x0024) plen 3  #2867 [hci0] 36.058743
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #2868 [hci0] 36.058926
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 36.058946
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 36.058946
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248   #2869 [hci0] 36.058972
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4              #2870 [hci0] 36.059347
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended... (0x03|0x0052) plen 241  #2871 [hci0] 36.059368
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4              #2872 [hci0] 36.059734
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 36.059765
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 36.059774
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 37.448180
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #2873 [hci0] 37.448228
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #2874 [hci0] 37.448380
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6               #2875 [hci0] 37.448424
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                        #2876 [hci0] 37.448787
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 37.455970
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 37.455983
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 37.456013
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 39.072157
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 39.258186
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 39.258199
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2877 [hci0] 39.281346
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #2878 [hci0] 39.281728
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2879 [hci0] 39.281770
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #2880 [hci0] 39.282116
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2881 [hci0] 39.282153
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 3e 0d 24 00 46 10 00  .........>.$.F..
        af 58 10 80 a0 3e 2d 24 90 d5 03 a2 c9 aa c1 e2  .X...>-$........
        02 e9 fd dd 9e 3e 0d 24 90 3e 2d 29 74 84 20 d5  .....>.$.>-)t. .
        02 aa 41 e2 02 e9 fe dd 9e 3c 1d 49 08 46 00 20  ..A......<.I.F. 
        00 8c 28 58 00 00 20 b4 41 b6 40 04 30 80 40 a2  ..(X.. .A.@.0.@.
        89 9a 9a 92 41 46 30 20 00 a8 81 58 31 82 20 8c  ....AF0 ...X1. .
        08 4c 01 ff f3 3c 2d 49 08 46 10 20 00 b4 62 b6  .L...<-I.F. ..b.
        61 80 01 a0 91 a8 81 dd 9e ef f8 46 18 00 a0 96  a..........F....
        03 a8 09 46 08 00 a0 a0 42 f1 81 f1 01 54 10 80  ...F....B....T..
        02 c9 fb ec 08 dd 9e 92 00 3a 6f 9c bc ef fc 80  .........:o.....
        e0 90 10 49 ff ff eb 96 3b 49 ff ff e8 ec 04 3a  ...I....;I.....:
        6f 9c 84 dd 9e 3a 6f a4 bc ef fc 84 c0 81 00 50  o....:o........P
        90 ff fe d5 0e 38 04 18 00 84 2a 4c 00 c0 05 84  .....8....*L....
        0d 49 ff ff e4 38 04 18 00 9d b1 49 ff ff df e2  .I...8.....I....
        c9 e9 f2 ec 04 3a 6f a4 84 dd 9e 92 00 ef f8     .....:o........ 
> HCI Event: Vendor (0xff) plen 5                        #2882 [hci0] 39.282530
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #2883 [hci0] 39.282567
        01 01 fb 00 02 3c 2d 3a f7 44 01 c2 00 40 21 00  .....<-:.D...@!.
        16 46 18 00 00 04 30 80 42 46 08 00 a0 58 31 80  .F....0.BF...X1.
        80 14 30 80 42 a0 c3 44 4f ff cf f3 81 80 20 f3  ..0.B..DO..... .
        01 40 31 90 02 f3 81 f3 01 a8 c3 a8 8c ec 08 dd  .@1.............
        9e 92 00 54 10 80 0c 92 22 96 00 96 90 c1 6c 40  ...T....".....l@
        30 1c 09 44 00 00 22 4c 20 00 12 5c f1 00 23 e8  0..D.."L ..\..#.
        05 8e 11 4c 20 40 61 d5 08 8c 11 4c 20 00 0a 8c  ...L @a....L ...
        11 4c 20 40 5a d5 07 84 00 d5 42 84 00 d5 2a 84  .L @Z.....B...*.
        00 d5 14 84 42 4c 11 40 04 84 03 d5 0a 84 03 4c  ....BL.@.......L
        10 40 04 84 02 d5 05 56 00 80 01 5c 00 00 01 cb  .@.....V...\....
        05 44 21 40 00 40 00 08 04 84 42 4c 11 40 05 58  .D!@.@....BL.@.X
        00 00 0c d5 0c 84 43 4c 11 40 05 58 00 00 08 d5  ......CL.@.X....
        06 84 41 4c 11 40 04 58 00 00 04 cb 03 58 00 30  ..AL.@.X.....X.0
        00 84 42 4c 11 40 05 58 00 02 40 d5 0c 84 43 4c  ..BL.@.X..@...CL
        11 40 05 58 00 02 00 d5 06 84 41 4c 11 40 04 58  .@.X......AL.@.X
        00 00 40 cb 05 44 22 80 00 40 00 08 04 84 42     ..@..D"..@....B 
> HCI Event: Vendor (0xff) plen 5                        #2884 [hci0] 39.282915
        02 01 01 00 00                                   .....           

[ ... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255             #3497 [hci0] 39.399781
        01 01 fb 00 02 20 30 78 25 78 0a 00 00 5b 46 44  ..... 0x%x...[FD
        42 5d 20 52 39 28 30 78 25 78 29 20 3d 20 30 78  B] R9(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 30 28 30  %x...[FDB] R10(0
        78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b 46 44  x%x) = 0x%x..[FD
        42 5d 20 52 30 28 30 78 25 78 29 20 3d 20 30 78  B] R0(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 28 30 78  %x...[FDB] R1(0x
        25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b 46 44  %x) = 0x%x...[FD
        42 5d 20 52 32 28 30 78 25 78 29 20 3d 20 30 78  B] R2(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 4e 75 6d 20 20  %x...[FDB] Num  
        20 20 20 54 79 70 65 20 20 20 20 20 20 45 6e 62     Type      Enb
        20 41 64 64 72 65 73 73 20 20 20 20 72 61 6e 67   Address    rang
        65 0a 00 00 00 5b 46 44 42 5d 20 20 20 25 64 20  e....[FDB]   %d 
        20 20 20 20 20 20 20 25 64 20 20 20 20 20 20 20         %d       
        20 25 64 20 30 78 25 78 20 20 20 20 30 78 25 78   %d 0x%x    0x%x
        0a 00 00 00 00 5b 46 44 42 5d 20 54 6f 6f 20 6d  .....[FDB] Too m
        61 6e 79 20 68 61 72 64 77 61 72 65 20 62 72     any hardware br 
> HCI Event: Vendor (0xff) plen 5                        #3498 [hci0] 39.400149
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3499 [hci0] 39.400180
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                        #3500 [hci0] 39.400523
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133             #3501 [hci0] 39.400555
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #3502 [hci0] 39.400807
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5               #3503 [hci0] 39.400859
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #3504 [hci0] 39.400977
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6               #3505 [hci0] 39.401011
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                        #3506 [hci0] 39.503321
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                #3507 [hci0] 39.503390
> HCI Event: Command Complete (0x0e) plen 4              #3508 [hci0] 39.511545
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x0003) plen 0  #3509 [hci0] 39.511609
> HCI Event: Command Complete (0x0e) plen 12             #3510 [hci0] 39.511750
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Versio.. (0x04|0x0001) plen 0  #3511 [hci0] 39.511774
> HCI Event: Command Complete (0x0e) plen 12             #3512 [hci0] 39.512031
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0         #3513 [hci0] 39.512066
> HCI Event: Command Complete (0x0e) plen 10             #3514 [hci0] 39.512211
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0     #3515 [hci0] 39.512266
> HCI Event: Command Complete (0x0e) plen 11             #3516 [hci0] 39.512396
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Dev.. (0x03|0x0023) plen 0  #3517 [hci0] 39.512415
> HCI Event: Command Complete (0x0e) plen 7              #3518 [hci0] 39.512567
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0      #3519 [hci0] 39.512586
> HCI Event: Command Complete (0x0e) plen 252            #3520 [hci0] 39.512882
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0   #3521 [hci0] 39.512902
> HCI Event: Command Complete (0x0e) plen 6              #3522 [hci0] 39.513042
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Su.. (0x03|0x0038) plen 0  #3523 [hci0] 39.513078
> HCI Event: Command Complete (0x0e) plen 5              #3524 [hci0] 39.513211
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC... (0x03|0x0039) plen 0  #3525 [hci0] 39.513230
> HCI Event: Command Complete (0x0e) plen 8              #3526 [hci0] 39.513409
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1     #3527 [hci0] 39.513429
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #3528 [hci0] 39.513558
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection... (0x03|0x0016) plen 2  #3529 [hci0] 39.513577
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4              #3530 [hci0] 39.513737
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0  #3531 [hci0] 39.513755
> HCI Event: Command Complete (0x0e) plen 7              #3532 [hci0] 39.513925
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Sup.. (0x08|0x0003) plen 0  #3533 [hci0] 39.513944
> HCI Event: Command Complete (0x0e) plen 12             #3534 [hci0] 39.514115
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported.. (0x08|0x001c) plen 0  #3535 [hci0] 39.514138
> HCI Event: Command Complete (0x0e) plen 12             #3536 [hci0] 39.514300
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Suppor.. (0x04|0x0002) plen 0  #3537 [hci0] 39.514318
> HCI Event: Command Complete (0x0e) plen 68             #3538 [hci0] 39.514544
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pair.. (0x03|0x0056) plen 1  #3539 [hci0] 39.514564
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #3540 [hci0] 39.514695
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1   #3541 [hci0] 39.514716
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #3542 [hci0] 39.514874
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Resp.. (0x03|0x0058) plen 0  #3543 [hci0] 39.514892
> HCI Event: Command Complete (0x0e) plen 5              #3544 [hci0] 39.515045
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #3545 [hci0] 39.515077
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14             #3546 [hci0] 39.515235
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8       #3547 [hci0] 39.515281
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4              #3548 [hci0] 39.515419
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link... (0x03|0x000d) plen 7  #3549 [hci0] 39.515438
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8              #3550 [hci0] 39.515595
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Lin.. (0x02|0x000f) plen 2  #3551 [hci0] 39.515617
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4              #3552 [hci0] 39.515770
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Ac.. (0x03|0x001b) plen 0  #3553 [hci0] 39.515788
> HCI Event: Command Complete (0x0e) plen 8              #3554 [hci0] 39.515956
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0  #3555 [hci0] 39.515975
> HCI Event: Command Complete (0x0e) plen 5              #3556 [hci0] 39.516124
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8    #3557 [hci0] 39.516143
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4              #3558 [hci0] 39.516305
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum D.. (0x08|0x002f) plen 0  #3559 [hci0] 39.516324
> HCI Event: Command Complete (0x0e) plen 12             #3560 [hci0] 39.516498
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested.. (0x08|0x0023) plen 0  #3561 [hci0] 39.516517
> HCI Event: Command Complete (0x0e) plen 8              #3562 [hci0] 39.516665
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Sup.. (0x03|0x006d) plen 2  #3563 [hci0] 39.516683
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #3564 [hci0] 39.516849
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #3565 [hci0] 39.516867
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14             #3566 [hci0] 39.517026
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Lin.. (0x03|0x0012) plen 7  #3567 [hci0] 39.517079
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6              #3568 [hci0] 39.517223
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pa.. (0x03|0x0063) plen 8  #3569 [hci0] 39.517242
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4              #3570 [hci0] 39.517420
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x000b) plen 0  #3571 [hci0] 39.517439
> HCI Event: Command Complete (0x0e) plen 8              #3572 [hci0] 39.517568
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizat.. (0x03|0x0077) plen 0  #3573 [hci0] 39.517587
> HCI Event: Command Complete (0x0e) plen 11             #3574 [hci0] 39.517756
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conn.. (0x03|0x007a) plen 1  #3575 [hci0] 39.517774
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #3576 [hci0] 39.517931
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggeste.. (0x08|0x0024) plen 4  #3577 [hci0] 39.517949
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4              #3578 [hci0] 39.518105
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3   #3579 [hci0] 39.518124
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #3580 [hci0] 39.518284
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 39.518308
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #3581 [hci0] 39.518374
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4              #3582 [hci0] 39.518537
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #3583 [hci0] 39.518556
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #3584 [hci0] 39.518794
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of De.. (0x03|0x0024) plen 3  #3585 [hci0] 39.518813
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #3586 [hci0] 39.518947
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 39.518960
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 39.518960
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248   #3587 [hci0] 39.518984
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4              #3588 [hci0] 39.519455
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended... (0x03|0x0052) plen 241  #3589 [hci0] 39.519476
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4              #3590 [hci0] 39.519848
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 39.519877
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 39.519885
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 40.960184
        Powered: Disabled (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #3591 [hci0] 40.960231
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #3592 [hci0] 40.960392
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x006f) plen 6               #3593 [hci0] 40.960432
        01 06 02 00 00 00                                ......          
> HCI Event: Vendor (0xff) plen 5                        #3594 [hci0] 40.960783
        02 06 01 00 00                                   .....           
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 40.968226
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 40.968235
        Current settings: 0x00000ad2
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:00:46:76:22:01                               [hci0] 40.968274
@ MGMT Command: Set Powered (0x0005) plen 1           {0x0001} [hci0] 43.492165
        Powered: Enabled (0x01)
= Open Index: 00:00:46:76:22:01                                [hci0] 43.677499
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 43.677514
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3595 [hci0] 43.700635
        01 01 fb 00 01 ff ff ff ff 3f 00 00 00 44 43 00  .........?...DC.
        00 f0 aa 02 00 34 88 02 00 bc c3 00 00 7c 58 05  .....4.......|X.
        00 88 16 08 00 d8 c1 07 00 8c 4b 07 00 bc 3e 08  ..........K...>.
        00 cc 20 05 00 bc d6 07 00 84 34 08 00 1c bf 05  .. .......4.....
        00 68 2a 08 00 e4 f5 07 00 98 17 05 00 b0 c9 06  .h*.............
        00 44 13 08 00 bc c3 04 00 e8 01 05 00 94 ad 07  .D..............
        00 58 de 05 00 80 a8 07 00 24 63 06 00 1c 7b 07  .X.......$c...{.
        00 70 f4 04 00 fc 82 06 00 28 fa 05 00 24 b2 07  .p.......(...$..
        00 78 3b 06 00 58 b9 06 00 f4 a4 07 00 2c 70 08  .x;..X.......,p.
        00 34 50 05 00 00 55 05 00 a4 6a 07 00 b4 33 06  .4P...U...j...3.
        00 08 36 06 00 00 00 00 00 00 00 00 00 00 00 00  ..6.............
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #3596 [hci0] 43.701010
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3597 [hci0] 43.701067
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 68 d1 09 00 d4 cd 09 00 9c cd 09 00 dc  ...h............
        c7 09 00 b8 19 0a 00 24 6f 0a 00 1c 56 0a 00 2c  .......$o...V..,
        bc 0a 00 10 6f 0a 00 a4 33 0a 00 38 6f 0a 00 d4  ....o...3..8o...
        8a 0a 00 34 3d 0a 00 98 77 0a 00 18 71 0a 00 24  ...4=...w...q..$
        05 0a 00 2c b4 0a 00 e8 d8 09 00 9c 32 0a 00 38  ...,........2..8
        51 0a 00 e4 01 0a 00 54 1f 0a 00 5c 06 0a 00 a0  Q......T...\....
        5c 0a 00 74 0c 0a 00 94 59 0a 00 40 b4 0a 00 00  \..t....Y..@....
        5e 0a 00 d0 01 0a 00 4c 25 0a 00 4c 7d 0a 00 04  ^......L%..L}...
        e0 09 00 68 6d 0a 00 20 13 0a 00 64 6b 0a 00 14  ...hm.. ...dk...
        d4 0a 00 e8 36 0a 00 78 19 0a 00 00 00 00 00 00  ....6..x........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00     ............... 
> HCI Event: Vendor (0xff) plen 5                        #3598 [hci0] 43.701413
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3599 [hci0] 43.701447
        01 01 fb 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 3e 0d 24 00 46 10 00  .........>.$.F..
        af 58 10 80 a0 3e 2d 24 90 d5 03 a2 c9 aa c1 e2  .X...>-$........
        02 e9 fd dd 9e 3e 0d 24 90 3e 2d 29 74 84 20 d5  .....>.$.>-)t. .
        02 aa 41 e2 02 e9 fe dd 9e 3c 1d 49 08 46 00 20  ..A......<.I.F. 
        00 8c 28 58 00 00 20 b4 41 b6 40 04 30 80 40 a2  ..(X.. .A.@.0.@.
        89 9a 9a 92 41 46 30 20 00 a8 81 58 31 82 20 8c  ....AF0 ...X1. .
        08 4c 01 ff f3 3c 2d 49 08 46 10 20 00 b4 62 b6  .L...<-I.F. ..b.
        61 80 01 a0 91 a8 81 dd 9e ef f8 46 18 00 a0 96  a..........F....
        03 a8 09 46 08 00 a0 a0 42 f1 81 f1 01 54 10 80  ...F....B....T..
        02 c9 fb ec 08 dd 9e 92 00 3a 6f 9c bc ef fc 80  .........:o.....
        e0 90 10 49 ff ff eb 96 3b 49 ff ff e8 ec 04 3a  ...I....;I.....:
        6f 9c 84 dd 9e 3a 6f a4 bc ef fc 84 c0 81 00 50  o....:o........P
        90 ff fe d5 0e 38 04 18 00 84 2a 4c 00 c0 05 84  .....8....*L....
        0d 49 ff ff e4 38 04 18 00 9d b1 49 ff ff df e2  .I...8.....I....
        c9 e9 f2 ec 04 3a 6f a4 84 dd 9e 92 00 ef f8     .....:o........ 
> HCI Event: Vendor (0xff) plen 5                        #3600 [hci0] 43.701796
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3601 [hci0] 43.701826
        01 01 fb 00 02 3c 2d 3a f7 44 01 c2 00 40 21 00  .....<-:.D...@!.
        16 46 18 00 00 04 30 80 42 46 08 00 a0 58 31 80  .F....0.BF...X1.
        80 14 30 80 42 a0 c3 44 4f ff cf f3 81 80 20 f3  ..0.B..DO..... .
        01 40 31 90 02 f3 81 f3 01 a8 c3 a8 8c ec 08 dd  .@1.............
        9e 92 00 54 10 80 0c 92 22 96 00 96 90 c1 6c 40  ...T....".....l@
        30 1c 09 44 00 00 22 4c 20 00 12 5c f1 00 23 e8  0..D.."L ..\..#.
        05 8e 11 4c 20 40 61 d5 08 8c 11 4c 20 00 0a 8c  ...L @a....L ...
        11 4c 20 40 5a d5 07 84 00 d5 42 84 00 d5 2a 84  .L @Z.....B...*.
        00 d5 14 84 42 4c 11 40 04 84 03 d5 0a 84 03 4c  ....BL.@.......L
        10 40 04 84 02 d5 05 56 00 80 01 5c 00 00 01 cb  .@.....V...\....
        05 44 21 40 00 40 00 08 04 84 42 4c 11 40 05 58  .D!@.@....BL.@.X
        00 00 0c d5 0c 84 43 4c 11 40 05 58 00 00 08 d5  ......CL.@.X....
        06 84 41 4c 11 40 04 58 00 00 04 cb 03 58 00 30  ..AL.@.X.....X.0
        00 84 42 4c 11 40 05 58 00 02 40 d5 0c 84 43 4c  ..BL.@.X..@...CL
        11 40 05 58 00 02 00 d5 06 84 41 4c 11 40 04 58  .@.X......AL.@.X
        00 00 40 cb 05 44 22 80 00 40 00 08 04 84 42     ..@..D"..@....B 
> HCI Event: Vendor (0xff) plen 5                        #3602 [hci0] 43.702170
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3603 [hci0] 43.702204
        01 01 fb 00 02 4c 11 40 05 58 00 01 20 d5 0c 84  .....L.@.X.. ...
        43 4c 11 40 05 58 00 00 20 d5 06 84 41 4c 11 40  CL.@.X.. ...AL.@
        04 58 00 01 00 58 00 00 90 d5 02 84 00 dd 9e 92  .X...X..........
        00 3a 6f 98 bc 2e 34 db 4c 97 80 44 00 00 ff 96  .:o...4.L..D....
        88 4c 30 00 1d 80 23 3e 64 a7 f8 80 06 49 ff ff  .L0...#>d....I..
        7e 92 00 3c 2d 29 d5 80 20 80 06 dd 22 46 18 10  ~..<-).. ..."F..
        60 54 63 00 40 14 00 80 98 c6 09 46 08 10 60 04  `Tc.@......F..`.
        10 00 99 42 10 c0 08 14 10 00 99 3a 6f 98 84 dd  ...B.......:o...
        9e 44 40 00 22 54 00 00 0c 96 90 92 02 42 10 9c  .D@."T.......B..
        0b 4c 22 00 4e 5c f1 00 23 e8 06 44 50 00 11 4c  .L".N\..#..DP..L
        22 c0 85 d5 66 8c 91 4c 22 00 24 44 50 00 44 da  "...f..L".$DP.D.
        7d 9e 82 96 90 e6 42 e8 06 9c 9c b4 82 58 42 11  }.....B......XB.
        00 b6 82 9e 81 96 90 e6 42 e8 06 9c 9c b4 82 58  ........B......X
        42 00 10 b6 82 c9 0d 50 41 80 10 b4 a4 50 21 80  B......PA....P!.
        14 58 52 8f 00 b6 a4 b4 82 58 42 00 0e b6 82 9e  .XR......XB.....
        82 96 90 e6 42 e8 08 9c 9c b4 82 46 50 d0 00     ....B......FP.. 
> HCI Event: Vendor (0xff) plen 5                        #3604 [hci0] 43.702554
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3605 [hci0] 43.702584
        01 01 fb 00 02 40 42 14 04 b6 82 9e 81 96 90 e6  .....@B.........
        42 e8 08 9c 9c b4 82 46 50 00 c0 40 42 14 04 b6  B......FP..@B...
        82 c9 09 50 21 80 10 b4 82 46 50 b0 a0 40 42 14  ...P!....FP..@B.
        04 b6 82 9e 82 96 90 e6 42 e8 07 50 21 80 0c b4  ........B..P!...
        82 58 42 09 00 b6 82 9e 81 96 90 e6 42 e8 07 50  .XB.........B..P
        21 80 08 b4 82 42 42 4c 08 b6 82 c9 0d 50 21 80  !....BBL.....P!.
        14 b4 82 50 11 80 10 58 42 07 00 b6 82 b4 41 58  ...P...XB.....AX
        21 00 06 b6 41 9e 42 96 48 e6 22 e8 07 50 11 80  !...A.B.H."..P..
        08 b4 41 58 21 05 00 b6 41 9e 01 96 00 e6 02 e8  ..AX!...A.......
        07 50 01 80 0c b4 20 58 10 80 04 b6 20 8c 68 b4  .P.... X.... .h.
        03 46 10 20 00 58 10 80 03 40 00 04 04 b6 03 dd  .F. .X...@......
        9e 92 00 3a 6f a4 bc ef d4 50 7f 80 04 97 80 54  ...:o....P.....T
        90 80 ff 54 81 00 ff 80 07 84 20 44 20 00 24 49  ...T...... D .$I
        fb c4 cc 54 03 00 0c c0 07 80 06 80 29 80 48 80  ...T........).H.
        67 49 ff ff 53 50 0f 80 04 a0 81 46 18 10 60 14  gI..SP.....F..`.
        20 80 32 a0 82 14 20 80 33 a0 83 14 20 80 34      .2... .3... .4 
> HCI Event: Vendor (0xff) plen 5                        #3606 [hci0] 43.702927
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3607 [hci0] 43.702961
        01 01 fb 00 02 a0 84 14 20 80 35 a0 85 14 20 80  ........ .5... .
        36 a0 86 14 20 80 37 a0 87 14 20 80 38 04 00 00  6... .7... .8...
        08 14 00 80 39 ec 2c 3a 6f a4 84 dd 9e 3a 6f a0  ....9.,:o....:o.
        bc 97 80 3c 6f 36 d3 3c 3d 29 ce 80 06 54 80 80  ...<o6.<=)...T..
        ff 97 d0 dd 23 3c 1d 29 cf 80 06 dd 21 80 47 80  ....#<.)....!.G.
        06 80 28 49 ff ff b3 3c 1d 29 d3 80 06 dd 21 3c  ..(I...<.)....!<
        1d 29 d2 80 06 dd 21 3a 6f a0 84 dd 9e 3a 6f 98  .)....!:o....:o.
        bc 2e 24 a7 f5 40 60 20 09 96 00 97 b0 4c 20 00  ..$..@` .....L .
        0d 3e 04 a7 f5 3c 1d 36 d3 4c 10 00 07 2e 24 a7  .>...<.6.L....$.
        f9 80 26 49 ff ff cd 2e 14 a7 f9 3e 64 a7 f8 80  ..&I.......>d...
        06 49 ff fe ce 3a 6f 98 84 dd 9e 92 00 96 80 96  .I...:o.........
        14 c0 05 44 32 50 10 40 00 8c 02 54 31 00 02 c3  ...D2P.@...T1...
        07 44 41 a0 80 40 30 90 02 40 00 0c 04 54 31 00  .DA..@0..@...T1.
        04 c3 05 54 30 81 45 40 00 0c 04 54 31 00 08 c3  ...T0.E@...T1...
        05 54 30 82 2a 40 00 0c 04 54 31 00 10 c3 07 40  .T0.*@...T1....@
        30 d0 09 40 31 d0 08 40 00 0c 04 54 21 00 20     0..@1..@...T!.  
> HCI Event: Vendor (0xff) plen 5                        #3608 [hci0] 43.703303
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3609 [hci0] 43.703554
        01 01 fb 00 02 c2 07 46 20 3f c0 40 10 88 02 40  .......F ?.@...@
        00 04 04 dd 9e 92 00 3b ff fc bc ef fc 84 68 96  .......;......h.
        00 96 49 4c 01 80 04 49 fb 48 7e ec 04 3b ff fc  ..IL...I.H~..;..
        84 dd 9e 3a 6f 98 bc 84 62 80 41 4c 01 c0 62 84  ...:o...b.AL..b.
        01 4c 10 40 3c 2e 04 eb c0 4c 00 80 38 46 18 10  .L.@<....L..8F..
        20 58 10 80 04 b4 01 58 00 00 20 b6 01 84 0a b4   X.....X.. .....
        41 58 21 00 10 b6 41 b4 41 58 21 00 01 b6 41 49  AX!...A.AX!...AI
        fb 22 48 46 18 10 21 58 10 81 04 b4 41 84 08 42  ."HF..!X....A..B
        21 48 08 b6 41 b4 41 42 21 4c 08 b6 41 49 fb 25  !H..A.AB!L..AI.%
        19 46 18 10 08 58 10 80 14 b4 41 84 0a 58 21 00  .F...X....A..X!.
        02 b6 41 b4 41 58 21 00 08 b6 41 b4 41 58 21 00  ..A.AX!...A.AX!.
        20 b6 41 49 fb 22 26 d5 26 46 08 10 20 58 00 00   .AI."&.&F.. X..
        04 b4 20 58 10 80 20 b6 20 b4 20 42 10 90 09 b6  .. X.. . . B....
        20 ca 0d 46 08 10 21 58 00 01 04 b4 20 42 10 c8   ..F..!X.... B..
        09 b6 20 b4 20 42 10 cc 09 b6 20 2e 04 ec 09 c8  .. . B.... .....
        0a 46 08 10 20 a0 41 58 10 a0 00 a8 41 d5 03     .F.. .AX....A.. 
> HCI Event: Vendor (0xff) plen 5                        #3610 [hci0] 43.703907
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3611 [hci0] 43.703941
        01 01 fb 00 02 49 fb 2e 3c 3a 6f 98 84 dd 9e 92  .....I..<:o.....
        00 3a 6f aa bc ef e4 2e 64 e9 fc 96 d8 97 68 f1  .:o.....d.....h.
        84 f2 83 f3 81 97 e0 f5 85 83 80 c6 02 d5 0f f1  ................
        03 c9 10 c8 0f 44 10 00 20 44 20 00 12 46 30 00  .....D.. D ..F0.
        ae 58 31 88 cc 84 83 49 fb 4a fd 84 03 48 00 01  .X1....I.J...H..
        26 3c 6d 3b 35 84 01 4c 60 40 1a 44 10 00 f6 4c  &<m;5..L`@.D...L
        70 80 1e 80 07 44 12 00 00 49 fb 7c aa 84 00 44  p....D...I.|...D
        10 00 20 44 20 00 12 46 30 00 ae 58 31 88 cc 80  .. D ..F0..X1...
        86 49 fb 4a e0 80 06 48 00 01 09 84 06 4c 60 40  .I.J...H.....L`@
        07 44 10 00 f6 4c 70 80 03 d5 07 3e 6c e9 d4 00  .D...Lp....>l...
        93 00 06 4e 92 00 16 80 07 44 12 00 00 49 fb 7c  ...N.....D...I.|
        88 84 00 44 10 00 20 44 20 00 12 46 30 00 ae 58  ...D.. D ..F0..X
        31 88 cc 84 81 49 fb 4a be 84 01 48 00 00 e7 f0  1....I.J...H....
        04 f1 01 96 01 50 80 00 02 89 01 f0 82 40 14 00  .....P.......@..
        13 80 06 49 fb 79 37 81 00 c8 15 80 07 44 11 00  ...I.y7......D..
        00 49 fb 7c 66 80 08 44 10 00 20 44 20 00 12     .I.|f..D.. D .. 
> HCI Event: Vendor (0xff) plen 5                        #3612 [hci0] 43.704286
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3613 [hci0] 43.704323
        01 01 fb 00 02 46 30 00 ae 58 31 88 cc 84 82 49  .....F0..X1....I
        fb 4a 9c 84 02 48 00 00 c5 44 00 00 f2 4c 70 40  .J...H...D...Lp@
        09 00 a3 00 0e 85 22 8d 41 10 a3 00 0e d5 34 44  ......".A.....4D
        10 00 f6 4c 70 c0 09 00 a3 00 0f 85 24 8d 41 10  ...Lp.......$.A.
        a3 00 0f d5 29 44 00 00 f4 4c 70 40 09 00 a3 00  ....)D...Lp@....
        0d 85 21 89 49 10 a3 00 0d d5 1e 9c 44 4c 70 c0  ..!.I.......DLp.
        09 00 a3 00 10 85 26 8d 41 10 a3 00 10 d5 14 44  ......&.A......D
        00 00 fa 4c 70 40 09 00 a3 00 11 85 23 8d 41 10  ...Lp@......#.A.
        a3 00 11 d5 09 00 a3 00 0c 84 04 8d 41 10 a3 00  ............A...
        0c 49 fb 6d c3 3c 6d 28 b0 f2 04 f3 03 f4 01 80  .I.m.<m(........
        3c 80 08 80 a9 dd 26 84 c4 10 64 00 08 84 c0 12  <.....&...d.....
        64 00 05 f1 03 c1 11 f0 01 04 64 00 01 40 a3 00  d.........d..@..
        00 80 01 d5 05 08 10 00 01 18 13 00 01 e2 ca e9  ................
        fb f0 01 12 04 00 05 4f c2 00 16 04 44 00 01 f1  .......O....D...
        01 f0 04 99 21 80 dc 98 e0 d5 05 08 13 00 01 18  ....!...........
        12 00 01 e2 83 e9 fb 02 34 00 05 f0 02 98 c3     ........4...... 
> HCI Event: Vendor (0xff) plen 5                        #3614 [hci0] 43.704668
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3615 [hci0] 43.704705
        01 01 fb 00 02 12 34 00 05 02 34 00 05 84 21 9c  ......4...4...!.
        da 12 34 00 05 4c 70 c0 09 f1 02 80 1c 44 20 e0  ..4..Lp......D .
        02 84 60 49 00 21 49 3e 0c e9 d4 49 fb 78 81 4e  ..`I.!I>...I.x.N
        93 00 1e 84 01 4c 70 00 11 2e 34 a2 9c 2e 04 a2  .....Lp...4.....
        9f 99 1b 9d 21 98 d8 99 20 98 20 9c db 98 03 4c  ....!... . ....L
        03 80 04 4c 33 c0 0c f1 05 80 07 49 fe ec e3 c8  ...L3......I....
        06 f1 05 f2 02 80 07 49 fe f0 9b 3c 1d 3a fb 84  .......I...<.:..
        40 44 00 00 17 49 fb 79 36 49 fb 78 24 c8 03 49  @D...I.y6I.x$..I
        fb 7b 3f 4e 93 00 05 84 08 49 fb 6d 4a 84 00 44  .{?N.....I.mJ..D
        10 00 20 44 20 00 11 46 30 00 ae 58 31 8f ec 49  .. D ..F0..X1..I
        fb 49 d7 84 00 ec 1c 3a 6f aa 84 dd 9e 3a 6f aa  .I.....:o....:o.
        bc ef dc 3c 3d de ba 96 00 f0 83 80 c2 80 e1 e2  ...<=...........
        03 e9 04 84 01 48 00 01 88 c9 0a 80 01 46 20 00  .....H.......F .
        ae 58 21 08 d0 44 30 03 b1 49 fb 36 7c a6 bd a7  .X!..D0..I.6|...
        3c 40 21 20 08 f0 03 40 21 10 04 00 13 80 22 46  <@! ...@!....."F
        48 20 e0 40 30 20 08 40 a1 90 00 c1 03 42 21     H .@0 .@.....B! 
> HCI Event: Vendor (0xff) plen 5                        #3616 [hci0] 43.705048
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3617 [hci0] 43.705095
        01 01 fb 00 02 7c 08 c6 3e 00 43 00 09 47 e0 03  .....|..>.C..G..
        f0 40 42 40 08 a6 75 40 42 78 02 40 21 10 04 c1  .@B@..u@Bx.@!...
        03 42 21 58 08 00 13 00 08 46 30 18 00 40 10 dc  .B!X.....F0..@..
        08 a7 34 40 10 8c 02 40 21 04 04 c4 03 42 21 64  ..4@...@!....B!d
        08 a7 33 c4 03 42 21 68 08 a7 32 c4 03 42 21 6c  ..3..B!h..2..B!l
        08 a7 31 c4 03 42 21 70 08 a7 36 c4 03 42 21 74  ..1..B!p..6..B!t
        08 a7 30 c4 03 42 21 78 08 00 43 00 0a a6 77 84  ..0..B!x..C...w.
        a4 95 a4 97 b0 40 40 84 1a 40 42 84 1b 40 62 18  .....@@..@B..@b.
        04 d5 0a 80 6a a2 5a 46 47 ff f0 40 10 90 02 b4  ....j.ZFG..@....
        63 40 21 04 04 00 93 80 00 a7 3e 14 9f 80 07 01  c@!.......>.....
        e3 80 01 15 ef 80 06 a6 3a f0 84 a6 7b f1 85 c4  ........:...{...
        03 58 63 00 01 a7 3f c4 03 58 63 00 02 00 43 80  .Xc...?..Xc...C.
        08 c4 03 58 63 00 08 02 93 80 05 00 83 80 09 46  ...Xc..........F
        30 1f f0 40 94 c0 08 40 94 8c 02 40 84 20 08 00  0..@...@...@. ..
        43 80 0c 40 84 a0 04 40 64 18 04 c4 03 42 63 64  C..@...@d....Bcd
        08 00 43 80 0d c4 03 42 63 68 08 00 43 80 24     ..C....Bch..C.$ 
> HCI Event: Vendor (0xff) plen 5                        #3618 [hci0] 43.705444
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3619 [hci0] 43.705474
        01 01 fb 00 02 c4 03 42 63 6c 08 00 43 80 25 c4  .......Bcl..C.%.
        03 42 63 70 08 00 43 80 0e c4 03 42 63 74 08 00  .Bcp..C....Bct..
        43 80 0f c4 03 42 63 78 08 00 43 80 10 c4 03 42  C....Bcx..C....B
        63 7c 08 50 55 00 0c b5 05 46 96 71 f0 00 43 80  c|.PU....F.q..C.
        11 58 94 8f ff 40 84 24 02 c4 03 58 84 10 00 00  .X...@.$...X....
        43 80 12 c4 03 58 84 20 00 00 43 80 13 c4 03 58  C....X. ..C....X
        84 40 00 00 43 80 14 c4 03 42 84 3c 08 00 43 80  .@..C....B.<..C.
        15 c4 03 42 84 54 08 00 43 80 16 c4 03 42 84 58  ...B.T..C....B.X
        08 00 43 80 17 c4 03 42 84 5c 08 00 43 80 18 c4  ..C....B.\..C...
        03 42 84 6c 08 00 43 80 19 c4 03 42 84 70 08 00  .B.l..C....B.p..
        43 80 1a c4 03 42 84 7c 08 50 15 00 6c b4 81 00  C....B.|.P..l...
        33 80 20 42 02 78 09 42 00 7c 09 c3 03 42 00 78  3. B.x.B.|...B.x
        08 00 43 80 21 c4 03 42 00 7c 08 46 98 20 f9 58  ..C.!..B.|.F. .X
        94 88 20 b4 69 47 c8 20 f9 42 41 f0 08 b6 89 b4  .. .iG. .BA.....
        7c 50 45 00 08 f4 81 42 41 fc 08 b6 9c f3 01 b6  |PE....BA.......
        c3 b7 05 b6 01 b4 dc 42 63 7c 09 b6 dc 50 45     .......Bc|...PE 
> HCI Event: Vendor (0xff) plen 5                        #3620 [hci0] 43.705817
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3621 [hci0] 43.705848
        01 01 fb 00 02 00 14 b4 c9 46 1f f8 73 42 63 70  .........F..sBcp
        09 b6 c9 58 10 8f ff b4 c4 00 43 80 1b 40 63 04  ...X......C..@c.
        02 c4 03 58 63 40 00 00 43 80 1c c4 03 42 63 4c  ...Xc@..C....BcL
        08 00 43 80 1d c4 03 42 63 50 08 00 43 80 1e c4  ..C....BcP..C...
        03 42 63 54 08 00 43 80 1f c4 03 42 63 58 08 f3  .BcT..C....BcX..
        04 f0 06 50 45 00 18 b4 84 04 9f 80 07 05 ef 80  ...PE...........
        05 40 11 c0 08 40 50 20 08 40 52 84 04 f4 84 50  .@...@P .@R....P
        15 00 20 50 35 00 1c 40 52 a4 04 40 4f 60 08 47  .. P5..@R..@O`.G
        c8 20 f9 81 5c 46 98 20 f9 40 52 90 04 05 e1 80  . ..\F. .@R.....
        00 b4 01 ba 84 14 55 00 05 14 64 80 08 46 88 20  ......U...d..F. 
        f9 f2 04 46 78 20 f9 46 38 20 f9 14 24 00 09 15  ...Fx .F8 ..$...
        e3 80 0a 14 01 80 0b 46 18 20 f9 f3 03 58 10 88  .......F. ...X..
        30 b6 61 81 01 b4 01 84 c0 58 00 28 00 b6 01 9d  0.a......X.(....
        b1 44 41 00 00 84 01 b5 28 4c 62 00 06 49 fc 94  .DA.....(Lb..I..
        dd 4e 95 ff f7 84 00 ec 24 3a 6f aa 84 dd 9e 3a  .N......$:o....:
        6f 9c bc ef fc 46 38 20 e0 96 00 40 60 20 08     o....F8 ...@` . 
> HCI Event: Vendor (0xff) plen 5                        #3622 [hci0] 43.706191
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #3623 [hci0] 43.706221
        01 01 fb 00 02 58 31 80 14 99 b3 b4 e6 49 ff fe  .....X1......I..
        5c 92 00 c8 09 b4 46 44 30 80 00 40 13 8c 02 40  \.....FD0..@...@
        10 88 04 b6 26 ec 04 3a 6f 9c 84 dd 9e 3a 6f aa  ....&..:o....:o.
        bc ef f4 96 80 84 00 f2 81 97 88 45 c2 aa d0 49  ...........E...I
        fc 6e 71 84 00 dd 3c 84 00 80 e0 49 fc 6e 73 f2  .nq...<....I.ns.
        01 3c 7f de c0 ca 02 d5 1e e6 c9 e9 03 80 07 d5  .<..............
        1b e6 c3 e9 0c 80 06 dd 3c 80 07 49 fc 6e 63 80  ........<..I.nc.
        06 49 fc 6e 58 46 00 01 00 d5 0b 80 07 dd 3c 80  .I.nXF........<.
        06 49 fc 6e 58 80 06 49 fc 6e 4d 46 00 01 40 3c  .I.nX..I.nMF..@<
        0f de c0 84 01 ec 0c 3a 6f aa 84 dd 9e 3b ff fc  .......:o....;..
        bc ef fc 49 fb 1b d1 92 00 ec 04 3b ff fc 84 dd  ...I.......;....
        9e 3b ff fc bc ef f4 50 0f 80 04 49 fb 1b af f0  .;.....P...I....
        01 ec 0c 3b ff fc 84 dd 9e 3a 6f 98 bc 84 41 4c  ...;.....:o...AL
        11 00 08 40 61 00 0c 84 02 4c 10 40 21 d5 0c 46  ...@a....L.@!..F
        28 10 40 04 31 00 46 40 00 80 0c 40 00 0c 04 14  (.@.1.F@...@....
        01 00 46 d5 1e 49 ff ff de 46 18 10 40 58 10     ..F..I...F..@X. 
> HCI Event: Vendor (0xff) plen 5                        #3624 [hci0] 43.706563
        02 01 01 00 00                                   .....           

[ ... ]

< HCI Command: Vendor (0x3f|0x006f) plen 255             #4213 [hci0] 43.819169
        01 01 fb 00 02 50 53 57 28 30 78 25 78 29 20 3d  .....PSW(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 32 38   0x%x..[FDB] R28
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 32 39 28 30 78 25 78 29 20 3d  FDB] R29(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 30   0x%x..[FDB] R30
        28 30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b  (0x%x) = 0x%x..[
        46 44 42 5d 20 52 31 35 28 30 78 25 78 29 20 3d  FDB] R15(0x%x) =
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 52 33 28   0x%x..[FDB] R3(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 34 28 30 78 25 78 29 20 3d 20  FDB] R4(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 35 28  0x%x...[FDB] R5(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 36 28 30 78 25 78 29 20 3d 20  FDB] R6(0x%x) = 
        30 78 25 78 0a 00 00 5b 46 44 42 5d 20 52 37 28  0x%x...[FDB] R7(
        30 78 25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b  0x%x) = 0x%x...[
        46 44 42 5d 20 52 38 28 30 78 25 78 29 20 3d     FDB] R8(0x%x) = 
> HCI Event: Vendor (0xff) plen 5                        #4214 [hci0] 43.819511
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #4215 [hci0] 43.819549
        01 01 fb 00 02 20 30 78 25 78 0a 00 00 5b 46 44  ..... 0x%x...[FD
        42 5d 20 52 39 28 30 78 25 78 29 20 3d 20 30 78  B] R9(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 30 28 30  %x...[FDB] R10(0
        78 25 78 29 20 3d 20 30 78 25 78 0a 00 5b 46 44  x%x) = 0x%x..[FD
        42 5d 20 52 30 28 30 78 25 78 29 20 3d 20 30 78  B] R0(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 52 31 28 30 78  %x...[FDB] R1(0x
        25 78 29 20 3d 20 30 78 25 78 0a 00 00 5b 46 44  %x) = 0x%x...[FD
        42 5d 20 52 32 28 30 78 25 78 29 20 3d 20 30 78  B] R2(0x%x) = 0x
        25 78 0a 00 00 5b 46 44 42 5d 20 4e 75 6d 20 20  %x...[FDB] Num  
        20 20 20 54 79 70 65 20 20 20 20 20 20 45 6e 62     Type      Enb
        20 41 64 64 72 65 73 73 20 20 20 20 72 61 6e 67   Address    rang
        65 0a 00 00 00 5b 46 44 42 5d 20 20 20 25 64 20  e....[FDB]   %d 
        20 20 20 20 20 20 20 25 64 20 20 20 20 20 20 20         %d       
        20 25 64 20 30 78 25 78 20 20 20 20 30 78 25 78   %d 0x%x    0x%x
        0a 00 00 00 00 5b 46 44 42 5d 20 54 6f 6f 20 6d  .....[FDB] Too m
        61 6e 79 20 68 61 72 64 77 61 72 65 20 62 72     any hardware br 
> HCI Event: Vendor (0xff) plen 5                        #4216 [hci0] 43.819891
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 255             #4217 [hci0] 43.819924
        01 01 fb 00 02 65 61 6b 20 70 6f 69 6e 74 0a 00  .....eak point..
        00 00 00 5b 46 44 42 5d 20 6f 75 74 20 6f 66 20  ...[FDB] out of 
        68 61 72 64 77 61 72 65 20 62 72 65 61 6b 20 70  hardware break p
        6f 69 6e 74 20 72 61 6e 67 65 0a 00 00 00 00 5b  oint range.....[
        46 44 42 5d 20 74 61 72 67 65 74 20 69 73 20 72  FDB] target is r
        75 6e 69 6e 67 0a 00 5b 46 44 42 5d 20 74 61 72  uning..[FDB] tar
        67 65 74 20 69 73 20 6e 6f 74 20 69 6e 20 64 65  get is not in de
        62 75 67 20 73 74 61 74 65 0a 00 5b 46 44 42 5d  bug state..[FDB]
        20 6e 6f 20 73 75 63 68 20 73 72 6e 61 6d 65 3a   no such srname:
        20 30 78 25 78 0a 00 5b 46 44 42 5d 20 74 61 72   0x%x..[FDB] tar
        67 65 74 20 69 73 20 61 6c 72 65 61 64 79 20 69  get is already i
        6e 20 64 65 62 75 67 20 73 74 61 74 65 0a 00 5b  n debug state..[
        46 44 42 5d 20 4e 6f 20 42 50 20 6e 75 6d 62 65  FDB] No BP numbe
        72 20 25 64 0a 00 00 5b 44 49 5d 20 73 65 6e 64  r %d...[DI] send
        5f 77 6d 74 5f 63 6d 64 0a 00 00 00 00 00 00 d8  _wmt_cmd........
        4f 08 00 e4 c4 06 00 70 18 08 00 fc 6e 0a 00     O......p....n.. 
> HCI Event: Vendor (0xff) plen 5                        #4218 [hci0] 43.820265
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 133             #4219 [hci0] 43.820304
        01 01 81 00 03 f8 b4 0a 00 b8 6e 0a 00 02 02 06  ..........n.....
        00 26 10 4e 10 00 c0 09 00 08 00 00 00 00 00 00  .&.N............
        00 01 00 00 00 01 00 00 00 11 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 d8 d7 09 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 98 df 0a 00 00 00 00  ................
        00 02 00 00 2d 00 00 00 00 00 00 00 00 00 00 00  ....-...........
        00 00 00 00 00 00 00 00 00 00 00 00 01 02 00 00  ................
        ff 00 00 02 d0 ff 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #4220 [hci0] 43.820553
        02 01 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 5               #4221 [hci0] 43.820610
        01 07 01 00 04                                   .....           
> HCI Event: Vendor (0xff) plen 5                        #4222 [hci0] 43.820723
        02 07 01 00 00                                   .....           
< HCI Command: Vendor (0x3f|0x006f) plen 6               #4223 [hci0] 43.820757
        01 06 02 00 00 01                                ......          
> HCI Event: Vendor (0xff) plen 5                        #4224 [hci0] 43.923076
        02 06 01 00 00                                   .....           
< HCI Command: Reset (0x03|0x0003) plen 0                #4225 [hci0] 43.923145
> HCI Event: Command Complete (0x0e) plen 4              #4226 [hci0] 43.931406
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x0003) plen 0  #4227 [hci0] 43.931441
> HCI Event: Command Complete (0x0e) plen 12             #4228 [hci0] 43.931618
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Versio.. (0x04|0x0001) plen 0  #4229 [hci0] 43.931642
> HCI Event: Command Complete (0x0e) plen 12             #4230 [hci0] 43.931896
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.2 (0x08) - Revision 8265 (0x2049)
        LMP version: Bluetooth 4.2 (0x08) - Subversion 1569 (0x0621)
        Manufacturer: MediaTek, Inc. (70)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0         #4231 [hci0] 43.931916
> HCI Event: Command Complete (0x0e) plen 10             #4232 [hci0] 43.932081
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0     #4233 [hci0] 43.932136
> HCI Event: Command Complete (0x0e) plen 11             #4234 [hci0] 43.932269
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 184  SCO max packet: 1
< HCI Command: Read Class of Dev.. (0x03|0x0023) plen 0  #4235 [hci0] 43.932288
> HCI Event: Command Complete (0x0e) plen 7              #4236 [hci0] 43.932435
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0      #4237 [hci0] 43.932454
> HCI Event: Command Complete (0x0e) plen 252            #4238 [hci0] 43.932747
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: MTK MT7622 #1
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0   #4239 [hci0] 43.932765
> HCI Event: Command Complete (0x0e) plen 6              #4240 [hci0] 43.932898
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Su.. (0x03|0x0038) plen 0  #4241 [hci0] 43.932918
> HCI Event: Command Complete (0x0e) plen 5              #4242 [hci0] 43.933070
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC... (0x03|0x0039) plen 0  #4243 [hci0] 43.933092
> HCI Event: Command Complete (0x0e) plen 8              #4244 [hci0] 43.933259
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1     #4245 [hci0] 43.933279
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4              #4246 [hci0] 43.933419
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection... (0x03|0x0016) plen 2  #4247 [hci0] 43.933441
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4              #4248 [hci0] 43.933605
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0  #4249 [hci0] 43.933624
> HCI Event: Command Complete (0x0e) plen 7              #4250 [hci0] 43.933780
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 8
< HCI Command: LE Read Local Sup.. (0x08|0x0003) plen 0  #4251 [hci0] 43.933801
> HCI Event: Command Complete (0x0e) plen 12             #4252 [hci0] 43.933972
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
< HCI Command: LE Read Supported.. (0x08|0x001c) plen 0  #4253 [hci0] 43.933991
> HCI Event: Command Complete (0x0e) plen 12             #4254 [hci0] 43.934162
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Suppor.. (0x04|0x0002) plen 0  #4255 [hci0] 43.934192
> HCI Event: Command Complete (0x0e) plen 68             #4256 [hci0] 43.934348
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 176 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set Triggered Clock Capture (Octet 30 - Bit 5)
          Truncated Page (Octet 30 - Bit 6)
          Truncated Page Cancel (Octet 30 - Bit 7)
          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
          Start Synchronization Train (Octet 31 - Bit 2)
          Set Reserved LT_ADDR (Octet 31 - Bit 4)
          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
          Read Synchronization Train Parameters (Octet 31 - Bit 7)
          Write Synchronization Train Parameters (Octet 32 - Bit 0)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
< HCI Command: Write Simple Pair.. (0x03|0x0056) plen 1  #4257 [hci0] 43.934369
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #4258 [hci0] 43.934515
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1   #4259 [hci0] 43.934537
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #4260 [hci0] 43.934742
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Resp.. (0x03|0x0058) plen 0  #4261 [hci0] 43.934772
> HCI Event: Command Complete (0x0e) plen 5              #4262 [hci0] 43.934902
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: -1 dbm (0xffffffff)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #4263 [hci0] 43.934921
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14             #4264 [hci0] 43.935091
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8       #4265 [hci0] 43.935139
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4              #4266 [hci0] 43.935270
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link... (0x03|0x000d) plen 7  #4267 [hci0] 43.935290
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8              #4268 [hci0] 43.935458
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 4
        Num keys: 0
< HCI Command: Write Default Lin.. (0x02|0x000f) plen 2  #4269 [hci0] 43.935477
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4              #4270 [hci0] 43.935631
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Ac.. (0x03|0x001b) plen 0  #4271 [hci0] 43.935650
> HCI Event: Command Complete (0x0e) plen 8              #4272 [hci0] 43.935811
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0  #4273 [hci0] 43.935830
> HCI Event: Command Complete (0x0e) plen 5              #4274 [hci0] 43.935978
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8    #4275 [hci0] 43.935998
        Mask: 0x0000000000000dd0
          LE Long Term Key Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Direct Advertising Report
          LE PHY Update Complete
> HCI Event: Command Complete (0x0e) plen 4              #4276 [hci0] 43.936164
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum D.. (0x08|0x002f) plen 0  #4277 [hci0] 43.936184
> HCI Event: Command Complete (0x0e) plen 12             #4278 [hci0] 43.936357
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120
< HCI Command: LE Read Suggested.. (0x08|0x0023) plen 0  #4279 [hci0] 43.936376
> HCI Event: Command Complete (0x0e) plen 8              #4280 [hci0] 43.936530
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 251
        TX time: 2120
< HCI Command: Write LE Host Sup.. (0x03|0x006d) plen 2  #4281 [hci0] 43.936549
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #4282 [hci0] 43.936707
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extend.. (0x04|0x0004) plen 1  #4283 [hci0] 43.936727
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14             #4284 [hci0] 43.936881
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Connectionless Slave Broadcast - Master
          Synchronization Train
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Lin.. (0x03|0x0012) plen 7  #4285 [hci0] 43.936922
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6              #4286 [hci0] 43.937083
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Pa.. (0x03|0x0063) plen 8  #4287 [hci0] 43.937102
        Mask: 0x0000000000b0c000
          Triggered Clock Capture
          Synchronization Train Complete
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4              #4288 [hci0] 43.937246
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Suppor.. (0x04|0x000b) plen 0  #4289 [hci0] 43.937265
> HCI Event: Command Complete (0x0e) plen 8              #4290 [hci0] 43.937421
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 2
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
        Number of vendor codecs: 0
< HCI Command: Read Synchronizat.. (0x03|0x0077) plen 0  #4291 [hci0] 43.937440
> HCI Event: Command Complete (0x0e) plen 11             #4292 [hci0] 43.937604
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 0.000 msec (0x0000)
        Timeout: 0.000 msec (0x00000000)
        Service data: 0x00
< HCI Command: Write Secure Conn.. (0x03|0x007a) plen 1  #4293 [hci0] 43.937624
        Support: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              #4294 [hci0] 43.937776
      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Write Suggeste.. (0x08|0x0024) plen 4  #4295 [hci0] 43.937799
        TX octets: 251
        TX time: 2120
> HCI Event: Command Complete (0x0e) plen 4              #4296 [hci0] 43.937961
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3   #4297 [hci0] 43.937980
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #4298 [hci0] 43.938134
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 43.938159
< HCI Command: LE Set Scan Resp.. (0x08|0x0009) plen 32  #4299 [hci0] 43.938227
        Length: 10
        Name (complete): builder
> HCI Event: Command Complete (0x0e) plen 4              #4300 [hci0] 43.938390
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1    #4301 [hci0] 43.938408
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4              #4302 [hci0] 43.938615
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of De.. (0x03|0x0024) plen 3  #4303 [hci0] 43.938635
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
> HCI Event: Command Complete (0x0e) plen 4              #4304 [hci0] 43.938786
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0002} [hci0] 43.938800
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
@ MGMT Event: Class Of Device Chan.. (0x0007) plen 3  {0x0001} [hci0] 43.938800
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Write Local Name (0x03|0x0013) plen 248   #4305 [hci0] 43.938824
        Name: builder
> HCI Event: Command Complete (0x0e) plen 4              #4306 [hci0] 43.939212
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended... (0x03|0x0052) plen 241  #4307 [hci0] 43.939237
        FEC: Not required (0x00)
        Name (complete): builder
        TX power: -1 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.11 (0x052b)
        16-bit Service UUIDs (complete): 4 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
> HCI Event: Command Complete (0x0e) plen 4              #4308 [hci0] 43.939611
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7        {0x0001} [hci0] 43.939644
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4            {0x0002} [hci0] 43.939653
        Current settings: 0x00000ad3
          Powered
          Connectable
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections



 



