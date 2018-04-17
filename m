Return-Path: <dave.anglin@bell.net>
X-Google-Smtp-Source: AB8JxZoqozB8wUEAqKekjkENvgdqlqBDXDavry8IT0Qie10On84QBBqiflbQOh8hLdKjgbhRKPV6
ARC-Seal: i=1; a=rsa-sha256; t=1524005635; cv=none;
        d=google.com; s=arc-20160816;
        b=Br1kmcw7xaAsk1tVi6ypkLahjKDnVFzURdFpU99k03uwzroMDOw0mpLFGsOKSWu9WB
         IEvW+bkNx9uTJ35pIUIL0zMMgcpSgfeuV10ohvtGbwSBTBACHTMBHwpoznVPTbd2+f+2
         YRtpKIGWNPjiugR94FItcg4hsC/MVbQcwrmYCRt2o3h+Z+D9vorPVOx+3/YCO80RzHuH
         ZzKz2HJMdnRbEfhhcL9hn2m8pWX/V4URSqEPJO710iJD8ds920S1q2Dclwh0BFMH62E4
         zYtUpCQRHoaMMfVUlRRMT1z9mmRm/NbOwj+vgdR3GeQBFqEGHBbihtdMVpbfHRIqTyMp
         UqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=5FpsXRduC+MzCAV2K9g3aIcn5oGANN0Cv6vY0jnGbZo=;
        b=dzmhkn3lhRsshqaZ9zPi2ogTJeywstVURHbvoWbbS35DKUC6IYw04BQofpQkn04fV7
         epu9j61oPIuqb2+3fIo9+Vxv8I7E1SFhZyZOgcVO+UZpxvGATPTUSbysJNYB2xdOrXSE
         f5P+b33cHzJU5nHrqLInVasYb6d+tQwvLAdSDkDl06MYhxgbVH/TLMvW+l8rsqDGyIXi
         rClIAurB8H5gjuzH83L5tiGXFpsnXPRBLesCxZegxF/iuwQxiEajfj7n+UQDHLy4xDIo
         8lLgoM/0HIt/ZwE25CLI2rdWWjOE2g0bBcp1YK11LCb00CsaueVdP+wHSpBLIP81PBrU
         +4Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.anglin@bell.net designates 184.150.200.207 as permitted sender) smtp.mailfrom=dave.anglin@bell.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.anglin@bell.net designates 184.150.200.207 as permitted sender) smtp.mailfrom=dave.anglin@bell.net
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
To: Sinan Kaya <okaya@codeaurora.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Helge Deller <deller@gmx.de>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
 <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
 <1523980508.3310.9.camel@HansenPartnership.com>
 <86252a65-265d-e081-b71f-42a0be6b1693@codeaurora.org>
From: John David Anglin <dave.anglin@bell.net>
Message-ID: <97fc18a7-b321-0039-0413-d461abc2097b@bell.net>
Date: Tue, 17 Apr 2018 18:53:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86252a65-265d-e081-b71f-42a0be6b1693@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=JtkelIwC c=1 sm=0 tr=0 a=V8DPTAhloC/wURew+oITug==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FBHGMhGWAAAA:8 a=XwEJ4ca0QzdjioWKIGAA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1598035733138776597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-17 2:28 PM, Sinan Kaya wrote:
> The correct terminology here would be to use observability. Yes, it can be
> cached in whatever part of the system for some amount of time as long as
> PCI device sees it in the correct order.
>
> Let's do this exercise.
> 1. OS writes to memory for some descriptor update
> 2. OS writes to the device via writel to hit a doorbell
> 3. Device comes and fetches the memory contents for the descriptor
>
> writel() of PA-RISC needs to ensure that 3. cannot bypass 1. This is typically
> done by a write barrier embedded into the writel() on relaxed architectures.
The sequence point after the argument evaluation for writel prevents the 
compiler from reordering
1 and 2.  Accesses to I/O space are strongly ordered on PA-RISC, so 1 
must occur before 2 (Page G-1
of the PA-RISC 2.0 Architecture).  Thus, the current code is okay.

Dave

-- 
John David Anglin  dave.anglin@bell.net
