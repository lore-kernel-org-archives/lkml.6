Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeDMKFo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:05:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753302AbeDMKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:05:42 -0400
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
 <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com>
 <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
 <2e09425d-0f27-3069-3421-e454ee70e3b2@redhat.com>
 <e06c459f-51bd-74d1-7a43-bf54231d08ba@codeaurora.org>
 <CAMuHMdXhFwhhZqa79F7_90VKhiegumizmswSsgDc9K+HP12wFA@mail.gmail.com>
 <1523542206.3689.10.camel@pengutronix.de>
 <CAMuHMdV+x9B1YVDiGkaeeG6tXV_nyzmJ3U=GkBAyhVuWPfdzFw@mail.gmail.com>
 <1523611347.3396.3.camel@pengutronix.de>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <07cab40d-c170-d5a9-2665-447d4a2f1538@redhat.com>
Date: Fri, 13 Apr 2018 12:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1523611347.3396.3.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 13/04/18 11:22, Philipp Zabel wrote:
[..]
> That also means it is impossible to use just one of the devices that
> share a reset line for vfio individually, while the other ones are still
> in use by the host. Currently the reset line is a shared resource
> similar to the iommu for devices in the same iommu_group.
> 
> Is there any mechanism in vfio that would allow modeling other shared
> resources apart from iommu?

No we only check the VFIO group viability at IOMMU level.
> 
> [...]
>>> For some of those it may be possible, but that is basically just a work-
>>> around for reality not matching expectations. There may be other cases
>>> where devices sharing a reset line are not even in the same parent node
>>> because they are controlled via a different bus. In general, I don't
>>> think it is feasible or desirable to force grouping of devices that
>>> share the same reset line into a common parent node.
>>
>> At least for Renesas R-Car SoCs, I think this is feasible, as all affected
>> devices are currently grouped under the same /soc node.
>> I added subnodes for all devices sharing resets (one for pwm, 4 for USB2,
>> and one for USB3; display doesn't have resets yet), and it still boots ;-)
> 
> Is this grouping enough to make sure all of the pwm/usb2/usb3 devices
> are only ever configured for vfio use together?
> 
> Assuming I have pwm[1-4] all sharing the same reset line, and I want
> pwm2 to be used by a vfio guest, I first have to make sure that all of
> pwm[1-4] are unbound, releasing their shared resets, before vfio-
> platform can request the same reset line as exclusive.
> 
> Thinking about it, if the pwm drivers keep their requested reset control
> around for the duration the device is bound, the reset controller
> framework should already kind of handle this - while any of the shared
> reset control handles is kept around, any exclusive request for the same
> reset control will fail with -EBUSY (and the other way around).
> But that requires all drivers to request the reset control during probe
> and release it during remove.
> 
>> However, ehci_platform_probe() cannot get its (optional) resets anymore.
>> Probably the reset controller framework needs to be taught to look for
>> shared resets in the parent node, too?
> 
> Hm, a generic framework shouldn't do such a thing, the parent node could
> be covered by a completely different binding.
> 
>>> My suggestion would be to relax the language in the reset.txt DT
>>> bindings doc.
>>
>> Which is fine to keep the status quo with the hardware designers, but makes
>> it less likely for non-whitelisted generic reset controller support to
>> become acceptable for the vfio people...
> 
> I still may be missing context, but I fail to see how
> 
> 	pwm@0 {
> 		resets = <&shared_reset_control>;
> 	};
> 
> 	pwm@1 {
> 		resets = <&shared_reset_control>;
> 	};
> 
> ->
> 
> 	pwms {
> 		resets = <&shared_reset_control>;
> 
> 		pwm@0 {
> 		};
> 
> 		pwm@1 {
> 		};
> 	};
> 
> makes any difference here, unless pwms gets bound to an actual driver
> that is used for vfio?

I don't think we are ready to assign pwms with VFIO as Alex emphasized
VFIO was meant to be used with IOMMU and I guess those devices do not
belong to any iommu group.

Thanks

Eric
> 
> regards
> Philipp
> 
