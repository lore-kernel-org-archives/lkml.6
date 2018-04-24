Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934284AbeDXNds (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:33:48 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:37749 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934444AbeDXNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:33:30 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: jakob.unterwurzacher@theobroma-systems.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <261ce72c1d27140b7ff13a5b925782b4>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5ADF321E.4060408@rock-chips.com>
Date: Tue, 24 Apr 2018 21:33:18 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-rockchip@lists.infradead.org
CC: klaus.goger@theobroma-systems.com,
        Huang Jiachai <sandy.huang@rock-chips.com>
Subject: Re: [regression, bisected] rockchip rk3399 video output breakage
References: <3beabd18-0c39-be65-cfe7-8498dc7c296b@theobroma-systems.com> <5ADF24F3.6070106@rock-chips.com> <fdd0fe29-2117-c67b-5dba-5d1ab0b19dd1@theobroma-systems.com>
In-Reply-To: <fdd0fe29-2117-c67b-5dba-5d1ab0b19dd1@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jokab,

Thanks for your reply.

On 04/24/2018 09:11 PM, Jakob Unterwurzacher wrote:
> On 24.04.18 14:37, JeffyChen wrote:
>>
>> right, i think it's a known issue, as the iommu failed to get clks:
>> [    1.525153] rk_iommu ff8f3f00.iommu: Failed to get clk 'iface': -2
>> [    1.525316] rk_iommu: probe of ff8f3f00.iommu failed with error -2
>> [    1.525484] rk_iommu ff903f00.iommu: Failed to get clk 'iface': -2
>> [    1.525643] rk_iommu: probe of ff903f00.iommu failed with error -2
>>
>>
>> there's a followed patch to add those clks to the dtsi, and also a fix
>> patch to make those clks optional(by heiko):
>>
>> https://www.spinics.net/lists/arm-kernel/msg645696.html
>>
>> http://lists.infradead.org/pipermail/linux-rockchip/2018-April/020349.html
>>
>
> Thanks, I tested both, and both get the screen to display some kernel
> output!
>
> However, I am getting some nasty error messages and the screen seems to
> refresh only once every 30 seconds:
>
>> [   15.586502] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*
>> [CRTC:30:crtc-0] flip_done timed out
>> [   25.826490] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*
>> [CONNECTOR:37:HDMI-A-1] flip_done timed out
>> [   36.066490] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*
>> [PLANE:28:plane-0] flip_done timed out
>> [   36.066504] [drm:drm_calc_timestamping_constants] crtc 30: hwmode:
>> htotal 2200, vtotal 1125, vdisplay 1080
>> [   36.066508] [drm:drm_calc_timestamping_constants] crtc 30: clock
>> 148500 kHz framedur 16666666 linedur 14814
>> [   36.076535] rockchip-vop ff8f0000.vop: [drm:vop_crtc_atomic_flush]
>> *ERROR* VOP vblank IRQ stuck for 10 ms
>> [   36.076577] WARNING: CPU: 1 PID: 83 at
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1004
>> vop_crtc_atomic_flush+0x1c0/0x1c8

this looks like an issue recently reported by heiko, we found that might 
due to an unbalanced irq disable in vop driver.

my test patch is:

+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1601,6 +1601,8 @@ static void vop_unbind(struct device *dev, struct 
device *master, void *data)
  {
         struct vop *vop = dev_get_drvdata(dev);

+       // Pair with the initial disable_irq()
+       enable_irq(vop->irq);



and i think sandy would send the real patch soon(maybe already sent?)
>
> Full dmesg with patch "arm64: dts: rockchip: add clocks in iommu nodes":
> https://gist.github.com/jakob-tsd/3fd49894d52dcd8a409eb9e6136b2d39
>
> Full dmesg with patch "iommu/rockchip: make clock handling optional":
> https://gist.github.com/jakob-tsd/da96572a40d11f0f6dff3ee481098138
> (looks the same)
>
> Thanks,
> Jakob
>
>
>
