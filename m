Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC31C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2922145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2922145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLCKSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:18:21 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:55239 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbeLCKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:18:20 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id TlITgqHuZfGaRTlIXgiIqg; Mon, 03 Dec 2018 11:17:54 +0100
Subject: Re: [PATCH v6 0/2] media: platform: Add Aspeed Video Engine driver
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh+dt@kernel.org,
        mchehab@kernel.org, linux-media@vger.kernel.org
References: <1543347457-59224-1-git-send-email-eajames@linux.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ed7f7598-c2a8-2a78-3513-d80344fd51b5@xs4all.nl>
Date:   Mon, 3 Dec 2018 11:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1543347457-59224-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGF8kZUiFojCTH0O8EzEGaoYDWEc+FlCfH3MyNeaho3s1u8rYqoNYgvvquQgdQybpwdyLeexpspG9Xiu2GO2R5ECtV+UGW2CTVY5ASalSEGP6bwBFMRh
 f2b/MT+OE08HjQNe87Moul7WynFhY+DqPxcKvfgMNa/9fDRgoCJIRQGZE4C/zvPwkE5bq1cEsZrm9P96bTNErUW0EGvJW2e4HQm48cLv8yX86pZnLILZ/67/
 xxUGY4W0YsvRoFu6lpbIp1u07ik8eSAIwfUW5RNITfHyjj/HPQnDupdewWQxyZbdXQa0PeHAvOk9FliO92j/1ThZb2e34ZditZo40UeumFs2r7P8JigtcXLH
 WtiIV4DT/aF2qnT5/bgRCfjE3BeodUB5orLLdvkxRMrvacIreAHQ6IRJfqr3QEQcC8NFXOQSbbs7Ake4EBCFqgQLzut7pQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 08:37 PM, Eddie James wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting as a service processor, the Video Engine can
> capture the host processor graphics output.
> 
> This series adds a V4L2 driver for the VE, providing the usual V4L2 streaming
> interface by way of videobuf2. Each frame, the driver triggers the hardware to
> capture the host graphics output and compress it to JPEG format.
> 
> v4l2-compliance SHA: ac9596560fedb3cd29148ef90b03778d76f1cd9a, 32 bits
> 
> Compliance test for device /dev/video0:
> 
> Driver Info:
> 	Driver name      : aspeed-video
> 	Card type        : Aspeed Video Engine
> 	Bus info         : platform:aspeed-video
> 	Driver version   : 4.18.19
> 	Capabilities     : 0x85200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x05200001
> 		Video Capture
> 		Read/Write
> 		Streaming
> 		Extended Pix Format
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 1 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK
> 	test VIDIOC_DV_TIMINGS_CAP: OK
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls (Input 0):
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 		fail: v4l2-test-controls.cpp(831): failed to find event for control 'Chroma Subsampling'

This is fixed in our master branch. Event handling was broken for a while.

I recommend that you upgrade, since this was a nasty little bug.

Regards,

	Hans

> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 3 Private Controls: 0
> 
> Format ioctls (Input 0):
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls (Input 0):
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls (Input 0):
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK
> 	test blocking wait: OK
> 	test MMAP: OK                                     
> 	test USERPTR: OK (Not Supported)
> 	test DMABUF: Cannot test, specify --expbuf-device
> 
> Total: 48, Succeeded: 47, Failed: 1, Warnings: 0
> 
> Changes since v5:
>  - Rework resolution change and v4l2 timings functions again with active and
>    detected timings.
>  - Renamed a few things.
>  - Fixed polarities in the timings.
> 
> Changes since v4:
>  - Set real min and max resolution in enum_dv_timings
>  - Add check for vb2_is_busy before settings the timings
>  - Set max frame rate to the actual max rather than max + 1
>  - Correct the input status to 0.
>  - Rework resolution change to only set the relevant h/w regs during startup or
>    when set_timings is called.
> 
> Changes since v3:
>  - Switch update reg function to use u32 clear rather than unsigned long mask
>  - Add timing information from host VGA signal
>  - Fix binding documentation mispelling
>  - Fix upper case hex values
>  - Add wait_prepare and wait_finish
>  - Set buffer state to queued (rather than error) if streaming fails to start
>  - Switch engine busy print statement to error
>  - Removed a couple unecessary type assignments in v4l2 ioctls
>  - Added query_dv_timings, fixed get_dv_timings
>  - Corrected source change event to fire if and only if size actually changes
>  - Locked open and release
> 
> Changes since v2:
>  - Switch to streaming interface. This involved a lot of changes.
>  - Rework memory allocation due to using videobuf2 buffers, but also only
>    allocate the necessary size of source buffer rather than the max size
> 
> Changes since v1:
>  - Removed le32_to_cpu calls for JPEG header data
>  - Reworked v4l2 ioctls to be compliant.
>  - Added JPEG controls
>  - Updated devicetree docs according to Rob's suggestions.
>  - Added myself to MAINTAINERS
> 
> Eddie James (2):
>   dt-bindings: media: Add Aspeed Video Engine binding documentation
>   media: platform: Add Aspeed Video Engine driver
> 
>  .../devicetree/bindings/media/aspeed-video.txt     |   26 +
>  MAINTAINERS                                        |    8 +
>  drivers/media/platform/Kconfig                     |    9 +
>  drivers/media/platform/Makefile                    |    1 +
>  drivers/media/platform/aspeed-video.c              | 1719 ++++++++++++++++++++
>  5 files changed, 1763 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>  create mode 100644 drivers/media/platform/aspeed-video.c
> 

