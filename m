Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84016C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6EE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C/wpnj6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6EE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeGSJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:22:14 -0400
Received: from mail-hk2apc01on0137.outbound.protection.outlook.com ([104.47.124.137]:49879
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeGSJWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kZfMVx2wuVG8R+oTu9e/wIlF9nTVQJLF8tj1//lV0A=;
 b=C/wpnj6/WT2J/lDzaqA+P0EFNxM6Meo1DH/3In7u3tFv0aXHQnOciXb/DmD3YfNIRMiYpLzt7abYS14IsOiYluWAVkJ4JuLTfYilLUFk7gSKbAxnxZ+z6EYQFlPvoNAgijAIU6u5arOML5xWfwsh9r/36GtphPyi3srjaPBbIHU=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM (10.170.136.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 08:40:00 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 08:40:00 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Topic: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Index: AQHUHzwUffUmbGD3SUGBq0C4VrI5YA==
Date:   Thu, 19 Jul 2018 08:39:59 +0000
Message-ID: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0095;6:yD2DAQ+fS2xSOTaFHq1ZxolMzktTRZkc4j3PtDoHWXP0UpnH0fcr/phLR6m0Qm7pBom62N1e33Ix+su9/fcj5kEZY/fNCcOAEVTKRVYKFKxS4eD0hmltH/n/+6BrPvJ6zY4oM/O8JgPN+PywI5aEUqLAZcr1QQ/zTo820Xjx9rDhtdm8pQBYV7WTqGZaHcIucaOMKnIkQVv4V8idVYtHYVH5TP6rM4byQ3FAgVLEzLRBGAGNnYf+7ob4wdUFj3/E5UpwM+kN7X7Pbb1pmT/BU/Ia9PPiVDwSUuOKt0dcm84olfPY+pfzkdomm3b2jsaOu98zx01AoYByArp//zDWbF+uPqSmQnkMXq+dSDMm6H5LmkifD//SDezTJm7MhVyuQ5qVm5qL7UYSrkukLeil2IK/VG5YaewDlXJ1eKvgChKuvh9/G+UpKF+T2TDs8XPJHXzGLLegKPs9vQojeohxWw==;5:y/H1sEmd2VAXjlVBbYhXeLA8IwPpdfpyVKyq4SfluvnIOAJ9Zscmw+qmwsmuf/zL7pWI24HteOF6gu1s5oiQkZKuZfuCWRKfK60G8rHyziu5rbbHiTd0456FHpvkzSHqRfud3ZqNLH8gRO1eo7cdABcphtRXiKVbXc4teD43vkA=;7:9LfI2JUraI6u3tKv072OOXwMOtEySSxuMVb0MLdbITkGVyXE1uAuunPM1hamQuNbsEhIoCSXXIwqGZ+dH6YD2NH7VAUS9WNLkSDFHx9390Qn+ziAg5FtN2a30JdU5Q978zO/jfDihJB1WEObREwXwVjAo/VG3AmLuMQAVNVVO8t5VUBS4Xd3CXubWybE60kJUY0Q9OGpgEraCNz7DufWxY8MqIXWdAOXs5CsTDIK75jDH6gOGIq+9f7KapqW38dv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9a1438bb-9ed8-43fc-512a-08d5ed53370e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0095;
x-ms-traffictypediagnostic: SG2P15301MB0095:
x-microsoft-antispam-prvs: <SG2P15301MB00953F94B9C382DA0AE7557F92520@SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0095;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0095;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(99286004)(22452003)(2900100001)(86612001)(66066001)(316002)(86362001)(72206003)(2906002)(68736007)(478600001)(486006)(97736004)(109986005)(2616005)(10290500003)(53936002)(1076002)(476003)(36756003)(10090500001)(1671002)(256004)(106356001)(6436002)(105586002)(6486002)(102836004)(5250100002)(6506007)(3846002)(7416002)(5660300001)(6116002)(59246006)(4326008)(305945005)(54906003)(7736002)(8936002)(81166006)(81156014)(8676002)(6512007)(26005)(14454004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0095;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VT+er2weKx54CHgrbNh2FLKgObAoYbjLzeTWiwqhOsb0OK4A7zckmlHn67R151sgxiWoheBcZQiVnA+OnnNZ12U8Orc4b/Yp69UEDS+mN34O1MJsPS/zwcJj6EHBXD9zJq53GvpORdj+dubO+Eg/5hTUMxmWIGeUT/9ckfOtpRlUJVkxJMdPdMXLkr9ldkEcQD0GLDITs6BH/vwEh4QhS8jyL9h/v0glg27AguIWIo6oJEOnaeNVqLtzFp6GDDWaBd6mTNYU4PyCd7/RSGN9IeJJhQQ1Z8Ps+S/1i9dLbQFp17P2umduapC1onM+cYDPdoPze+hUWKnxZhmMW9hj7cfdxXDadMD/Xq6QaVisIlQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1438bb-9ed8-43fc-512a-08d5ed53370e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 08:39:59.9232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0095
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V provides a para-virtualization hypercall HvFlushGuestPhysicalAddres=
sSpace
to flush nested VM address space mapping in l1 hypervisor and it's to reduc=
e overhead
of flushing ept tlb among vcpus. The tradition way is to send IPIs to all a=
ffected
vcpus and executes INVEPT on each vcpus. It will trigger several vmexits fo=
r IPI and
INVEPT emulation. The pv hypercall can help to flush specified ept table on=
 all vcpus
via one single hypercall.

Change since v2:
       - Make ept_pointers_match as tristate "check", "match" and "mismatch=
".
       Set "check" in vmx_set_cr3(), check all ept table pointers in hv_rem=
ote_flush_tlb()
       and call hypercall when all ept pointers are same.
       - Rename kvm_arch_hv_flush_remote_tlb with kvm_arch_flush_remote_tlb=
 and
       Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops->tlb_remote=
_flush
       - Fix issue that ignore updating tlbs_dirty during calling kvm_arch_=
flush_remote_tlbs()
       - Merge patch "KVM/VMX: Add identical ept table pointer check" and
       patch "KVM/x86: Add tlb_remote_flush callback support for vmx"

Change since v1:
       - Fix compilation error for non-x86 platform.
       - Use ept_pointers_match to check condition of identical ept
            table pointer and get ept pointer from struct vcpu_vmx->ept_poi=
nter.
       - Add hyperv_nested_flush_guest_mapping ftrace support
		    =20


Lan Tianyu (4):
  X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
    support
  X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
  KVM: Add tlb remote flush callback in kvm_x86_ops.
  KVM/x86: Add tlb_remote_flush callback support for vmx

 arch/x86/hyperv/Makefile            |  2 +-
 arch/x86/hyperv/nested.c            | 67 +++++++++++++++++++++++++++++++++=
+
 arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
 arch/x86/include/asm/kvm_host.h     | 11 ++++++
 arch/x86/include/asm/mshyperv.h     |  2 ++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
 arch/x86/kvm/vmx.c                  | 72 +++++++++++++++++++++++++++++++++=
+++-
 include/linux/kvm_host.h            |  7 ++++
 virt/kvm/kvm_main.c                 |  3 +-
 9 files changed, 183 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/hyperv/nested.c

--=20
2.14.3
