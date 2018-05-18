Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeERHA1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:00:27 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38610 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:00:25 -0400
X-Google-Smtp-Source: AB8JxZpdY56Op+Trz9/ZCIZFNIUwpS5BmB+aieJRylBLOWxzU9ovBKZDGlh7IPtWvEWP+9OozEUiAE5SM7PjV3exT14=
MIME-Version: 1.0
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 18 May 2018 15:00:24 +0800
Message-ID: <CANRm+Czbc61d+bHw1oTwUT3-MBNCU42NWD8=+GyrXATDyDzYEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] KVM: x86: hyperv: PV TLB flush for Windows guests
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,
2018-05-16 23:21 GMT+08:00 Vitaly Kuznetsov <vkuznets@redhat.com>:
> Changes since v3 [Radim Krcmar]:
> - PATCH2 fixing 'HV_GENERIC_SET_SPARCE_4K' typo added.
> - PATCH5 introducing kvm_make_vcpus_request_mask() API added.
> - Fix undefined behavior for hv->vp_index >= 64.
> - Merge kvm_hv_flush_tlb() and kvm_hv_flush_tlb_ex()
> - For -ex case preload all banks with a single kvm_read_guest().
>
> Description:
>
> This is both a new feature and a bugfix.
>
> Bugfix description:
>
> It was found that Windows 2016 guests on KVM crash when they have > 64
> vCPUs, non-flat topology (>1 core/thread per socket; in case it has >64
> sockets Windows just ignores vCPUs above 64) and Hyper-V enlightenments

We try the below command line, the Windows 2016 guest successfully to
login and there are 80 vCPUs can be observed in the guest w/o the
patchset, why you mentioned the crash and ignore?

/usr/local/bin/qemu-system-x86_64 -machine  pc-i440fx-rhel7.3.0  -m
8192 -smp 80,sockets=2,cores=40,threads=1  -device
ide-drive,bus=ide.0,drive=test -drive
id=test,if=none,file=/instanceimage/359b18ab-05bb-460d-9b53-89505bca68ed/359b18ab-05bb-460d-9b53-89505bca68ed_vda_1.qcow2
 -net nic,model=virtio -net user -monitor stdio -usb -usbdevice tablet
--enable-kvm --cpu host -vnc 0.0.0.0:2

Regards,
Wanpeng Li
