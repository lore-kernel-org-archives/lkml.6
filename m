Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCUO3q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:29:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35552 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeCUO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:29:43 -0400
X-Google-Smtp-Source: AG47ELsF6V/cAiC/NzWPpsqc3BFHXGJM4/OPOKpGzdiXU3H5mjciHXY4XntPP0JgzjjYfbYvZZ6AsA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 00/11] Move ad7746 out of staging
Date: Wed, 21 Mar 2018 11:28:48 -0300
Message-Id: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to move the cdc ad7746 driver out of staging. I have some
design questions though so I would introduce them here, along with a short
description of each patch.

*PATCH 0001 - Adjust arguments to match open parenthesis.
There were a couple CHECKS that still remained, so I got rid of them.

*PATCH 0002 - Fix multiple line dereference
In this case, I opted for avoiding the multiple line derefence and having a 80+
characters line instead as I consider that it improves readability. I may be
wrong though, so this patch could just be discarded.

*PATCH 0003 - Reorder includes alphabetically

*PATCH 0004 - Reorder variable declarations in an inverser-pyramid way

*PATCH 0005 - Remove unused defines
There were a few too many #defines that were not used at all, so I just removed
them. I guess if someone plans on extending the drivers functionality they can
be added again, but they were just wasting space as they were. Again, I could be
wrong with this decision so this patch could just be discarded.

*PATCH 0006 - Add dt-bindings
This patch adds dt bindings by populating the old pdata struct. It supports both
platform_data and dt-bindings but uses only one depending on CONFIG_OF. I chose
this way to avoid modifying too much the code, and introduce no errors (or as
few as I could), keeping the same functionality and maintaining support of the
platform_data.

*PATCH 0007 - Add remove()
I added a remove function so I could test that the driver probed properly when
compiled as a module with the new dt-bindings.

*PATCH 0008 - Add comments to clarify some of the calculations
I had to go through most of the datasheet to understand some of the math in the
code, so I added comments where I saw fit. (Comments on the comments are
welcome).

*PATCH 0009 - Add devicetree bindings documentation
Add documentation on the devicetree bindings, explaining the properties of it
and describing a short example.

*PATCH 0010 - Rename sysfs attrs to comply with the ABI
Comments are welcome on this one.
I shortened the names of the sysfs attrs to comply with the ABI:
<type>[Y]_calibbias_calibration -> <type>[Y]_calibbias
<type>[Y]_calibscale_calibration -> <type>[Y]_calibscale

The device supports 2 ways of calibrating the gain (from the datasheet):
'The gain can be changed by executing a capacitance gain
calibration mode, for which an external full-scale capacitance
needs to be connected to the capacitance input, or by writing a
user value to the capacitive gain register.'

The same for the offset calibration:
'One method of adjusting the offset is to connect a zero-scale
capacitance to the input and execute the capacitance offset
calibration mode. The calibration sets the midpoint of the
±4.096 pF range (that is, Output Code 0x800000) to that
zero-scale input.
Another method would be to calculate and write the offset cali-
bration register value, the LSB is value 31.25 aF (4.096 pF/2^17 ).'

The driver only supports the first way in both cases, as it only writes the
register that starts the calibration mode and doesn't allow the user to write
anything on other registers.

What I understand from the ABI is not so different when explaining calibbias and
calibscale:
'Description:
Hardware applied calibration {offset,scale factor} (assumed to fix production
inaccuracies).'

Maybe I'm missing something and the renaming is not good. I would be really
grateful if someone could shed some light on this for me.

*PATCH 0011 - Move cdc ad7746 driver out of staging to mainline iio
Move the files, modify the proper Kconfigs and the documentation.

That'd be all. Any feedback is welcome. I hope this gets out of staging :)

Cheers,

Hernán

Hernán Gonzalez (11):
  staging: iio: ad7746: Adjust arguments to match open parenthesis
  staging: iio: ad7746: Fix multiple line dereference
  staging: iio: ad7746: Reorder includes alphabetically
  staging: iio: ad7746: Reorder variable declarations
  staging: iio: ad7746: Remove unused defines
  staging: iio: ad7746: Add dt-bindings
  staging: iio: ad7746: Add remove()
  staging: iio: ad7746: Add comments
  staging: iio: ad7746: Add devicetree bindings documentation
  staging: iio: ad7746: Rename sysfs attrs to comply with the ABI
  Move cdc ad7746 driver out of staging to mainline iio

 .../devicetree/bindings/iio/cdc/ad7746.txt         |  32 ++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/cdc/Kconfig                            |  16 ++
 drivers/{staging => }/iio/cdc/ad7746.c             | 168 +++++++++++++++------
 drivers/staging/iio/cdc/Kconfig                    |  10 --
 .../staging => include/linux}/iio/cdc/ad7746.h     |   9 --
 6 files changed, 168 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ad7746.txt
 create mode 100644 drivers/iio/cdc/Kconfig
 rename drivers/{staging => }/iio/cdc/ad7746.c (84%)
 rename {drivers/staging => include/linux}/iio/cdc/ad7746.h (70%)

-- 
2.7.4
