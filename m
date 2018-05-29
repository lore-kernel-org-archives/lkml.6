Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933140AbeE2KDi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932753AbeE2J6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:08 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/9] Hid multitouch rewrite, support os system multi-axis devices
Date: Tue, 29 May 2018 11:57:51 +0200
Message-Id: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

this heavy rewrite of hid-multitouch serves two main purposes:
- the first point is to enable the support of the Totem on the Dell Canvas 27.
  This new type of devices (System Multi Axis) is used by Microsoft to show
  a new circular menu that is used by the second hand while you interact with
  your preferred hand with your tool.
  I couldn't enable it before because hid-multitouch expected to have only one
  multitouch collection, and this device is exported as a separate multitouch
  collextion in the same HID device than the one containing the touch sensor.

- the second point is to streamline the process of the multitouch events. We
  used to temporary store the events in a struct as they come in, and then do
  the processing on the cache we just made. When doing the processing was also
  not very clear. This made that even if hid-multitouch should IMO be merged in
  hid-core, we couldn't.

  The new processing of the events here adds a preparsing of the report in
  one HID collection (application usage), and from now on, the processing
  of the report is cleaner IMO. I still haven't merged hid-mt into hid-core,
  because even if I wrote a bunch of unit tests trying to not break any devices,
  we are not protected from a weird thing that magically happened before but is
  now broken.

I must say that when I worked on the tests, I came to realise that some legacy
Win7 devices were better handled now. Initially I thought my new code broke them
but comparing the outputs from https://github.com/bentiss/hid-devices before
and after the changes, the new changes are closer to what I would expect by
looking at the raw HID events.

I also included 2 patches to enable the Surface Dial. It's a BLE device similar
to the Totem from Dell, except that you can buy it for roughly $80 instead of
$1800 for the Canvas.


Dmitry, 2 patches are of interest for you:
- 1/9 Input: mt - export MT_TOOL in input_mt_init_slot()
- 7/9 HID: input: enable Totem on the Dell Canvas 27

The second one exports a new MT_TOOL. In theory, I think patch 1/9 could be
carried through your tree but it'll be better to have the full series applied
at once.

Cheers,
Benjamin

Benjamin Tissoires (9):
  Input: mt - export MT_TOOL in input_mt_init_slot()
  HID: multitouch: make sure the static list of class is not changed
  HID: multitouch: Store per collection multitouch data
  HID: multitouch: store a per application quirks value
  HID: multitouch: ditch mt_report_id
  HID: multitouch: remove one copy of values
  HID: input: enable Totem on the Dell Canvas 27
  HID: core: do not upper bound the collection stack
  HID: microsoft: support the Surface Dial

 drivers/hid/hid-core.c                   |  17 +-
 drivers/hid/hid-input.c                  |   3 +
 drivers/hid/hid-microsoft.c              |  49 +-
 drivers/hid/hid-multitouch.c             | 941 ++++++++++++++++++-------------
 drivers/input/input-mt.c                 |   1 +
 drivers/input/rmi4/rmi_2d_sensor.c       |   2 -
 drivers/input/touchscreen/atmel_mxt_ts.c |   2 -
 drivers/input/touchscreen/hideep.c       |   2 -
 drivers/input/touchscreen/wacom_w8001.c  |   2 -
 include/linux/hid.h                      |  15 +-
 include/uapi/linux/input.h               |   3 +-
 11 files changed, 616 insertions(+), 421 deletions(-)

-- 
2.14.3
