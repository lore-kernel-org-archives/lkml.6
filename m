Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161561AbeBNR6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:58:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161247AbeBNR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:58:03 -0500
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
To: "Serge E. Hallyn" <serge@hallyn.com>,
        "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
 <20180211215028.16210-1-metux@gmx.de> <20180211215028.16210-2-metux@gmx.de>
 <20180213071655.GA11240@mail.hallyn.com>
 <3a99edaf-0365-ec7e-4d2f-1e21dea007ac@gmx.de>
 <20180214145650.GA2102@mail.hallyn.com>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <23e3c1de-13e0-34ab-e2a8-b40c59e5b986@metux.net>
Date: Wed, 14 Feb 2018 18:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180214145650.GA2102@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:cNLapZpm3Txfrlm4PpYbTEaWhWEymEUf7uTDWJztT80hz9vkEgU
 InCJ6LogzryacdbsFIPdmGwJhLFIfLWzKcr+QNEndmpP3YBKCA28QPE4tY+Zq7QKWKg+pOk
 g/WPDqciqpm2MelGhiG4Mx3puymea0BJTWNA2tVvusHZN/dQI6ZA3rM58CcBUSzprqNYvWc
 W0lvdQ4n062OTBJMu/RMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y0Okj+P5Z3I=:ulQOogKz3lrV2sE1HOsCHG
 M63FogxCgB4e+ep1AVINaFiWNGGDSFDNqgy8MfxwaoAcRwMFpe2zGfEirRZNvzYABCGFifGIx
 uPpqUR9ArsuHgDGITt1XkmmhyiG8lhQI7WIHGdBGNvZibJzXd0Z42/vsgGu4kzA2ccjdwNX01
 AeDt9erp6q0IJfgE+BAU3+w7P/3KD+6pTV8c1ElKgEgXI5cXY0kOiuJw4kKk7ct8UA7aM4M7M
 nzO01QD1M0YbzF72aqTJpGeFjcsGazNTWPgOKghCrcEQveHnu6GQ5GcDEVm4Vo0xMr/MIU2Nl
 c+pQTK7Zd9Rx0kvR/CXL+mAwd2FGfyuUshHbGD1nljBFr5TGv3krGmnPrM5vCCd/44Vt8Brbx
 lIRe2N7k7nzHOmGdw8Qd49C0PXePqPkX+0Njzr2VaPEvKlwXfFV1UqSVT1HFHslYcF4AfBOw8
 jm1HCCpu9xpdHaMxgarhmIx1nO49SJ5URG+N/kSxKPQp2gsBVN5S9lV6yMDecEf+ZKDzytNto
 ymepPo6cfqYWkMFh9JFGEIUT+5R0GBZ8NPsAzIz1795XQaU2IZRG0P1f7XWIXJmoQBNYiXP2T
 YMZNWizylj7u99sjFtxprl0u4IfmnHsy2x6mv8kiZbJHJMPneiL4QQ8HRbiuNrjpqRpLiDNfy
 kFl0ZFODD6ceGHkXzd4oKUxrL4HQBxm1v/jT369lqkKYiqACYZkeEKOZCk0gm8P7ih/5dxYCc
 hnDX8O8ehcubH/fMW30tECNQieuFcn+1qglKKtWRzVbIEKnqSXf+bydmiiw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 15:56, Serge E. Hallyn wrote:

> If it's an out of tree module you'd have to do it this way, but if > it's in-tree, even as a module, adding a bit to the userns struct> 
would imo be ok.
Assuming one doesn't try to load the module when the kernel image
previously was built w/o it ;-) (well, could export some dummy
symbol for protection ;-)).

OTOH, that raises the question, where / how exactly the cap list
destruction / expiry should be done. My original plan was adding
a timer in the p9caps module that just scans for old entries.

Should the userns code just call back on userns destruction ?
(in that case it would be tricky to have it as a module)

>> the whole thing might become a bit more complex when introducing
>> plan9-like unprivileged mount operations. haven't sorted out how to
>> do that yet.
> 
> I hope you'll have a discussion here about that first.

Yes, of course - that's why I'm here :p

My current idea is introducing some special flag for disabling suid
completely and switch into an private namespace, where now the
unprivileged user can mount at will and create new mnt namespaces,
just like on Plan9.

I'll try some qnd hacks w/ a new syscall, lets see where it leads to,
and then sort out how to do that in a more appropriate way.

> Now speaking practically, I love the caphash idea, but it does
> have issues with a modern login system.  There are privileged
> things which login needs to do besides changing uid, including but
> not limited to:
> 1. setting limits
> 2. setting loginuid,
> 3. mounting things (polyinstantiated /tmp, decrypted homedir, etc)
> 4. setting selinux context

For now, I don't think that's necessary for doing things the Plan9 way.
Perhaps we later could extend the /dev/caphash interface w/ additional
parameters for that.

> (and of course gplv3 as Al pointed out is a blocker)

already fixed.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
