Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519738051; cv=none;
        d=google.com; s=arc-20160816;
        b=MQ0ww/Dee2xSErF4z5Kj7SwV1LvkDWVtTfKga54amlrRW9BDsAKr9sqIHU2QykStMV
         OUdfCLdWanWjdhqGlyBS6q19faO3Wde2XdGI/uF4j3ZZmahDRcGmKdJCYvEVnuen9sWU
         l+VAwv//tQzWm2RzvPdPnTofViWssnNz3DAT66mCTjdsk6/DQwI7k7+jMoJLIV3jL3N6
         zsmgeVY2xlZ5HFPmAImte+wOMDQ2yc3PWH8Hph7qYkyFZ3khAJ7P2NzyyEFaIPlp+KP3
         nYotxUbrWE2llR/QnHNl2pzHr8Wn/1BwPDtNzi6pymCKpD4V8vRWfWhZvnjUIxytKKXo
         rHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=qA+qlnepS59F3sVnKSg+EAXUhVpHV514cIJWLmw0WQE=;
        b=jtHG1mPpBPP2tyZ+OmncK+ZtsODfP73GSw1kFsVto9RoZ4uvv5TXssJxGtwJIr/MUo
         VjYMY6OllR3w6KWRPYkpozNQj7s0pWFoCQdROdEq7llFPqss5kG2L4jkQ8ZPHXTCDzUT
         qqrvxys9nwosv9sHEsQDB91qm8J5+rXNgmxaVVtlY0SMN4kNj9KQl/GVHDWMS+BGxdJC
         Fe+sLQPe5Axn5tkZ9Ixj2U3ywerZYs53Ln/d1IKa9MQSFA6G2KGYuNZPhMWdocqb5M39
         3SFVPkmC4NH3P8INoVVBLWjmDXkXVPCIuaRW5JoIYWu0Y7DGCA9pER5bWcRvIXj0utI6
         7kOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eiE2iWDz;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eiE2iWDz;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225effmrqsrhq5ceqEoxB58ifem62b0puht2yB/EpHLTrQgiGh6rGe+06NR3d5BXaa39tnVlRg==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH] Take mmap_min_addr into account while choosing
 unmapped address for x86-64.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180227085726.GC15357@dhcp22.suse.cz>
Date: Tue, 27 Feb 2018 16:27:29 +0300
Cc: tglx@linutronix.de,
 mingo@redhat.com,
 hpa@zytor.com,
 x86@kernel.org,
 kirill.shutemov@linux.intel.com,
 dsafonov@virtuozzo.com,
 hughd@google.com,
 gregkh@linuxfoundation.org,
 craigb@google.com,
 oleg@redhat.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6A5E9B0-4986-4CD4-B01A-B6218D859579@gmail.com>
References: <20180226211257.63067-1-blackzert@gmail.com>
 <20180227085726.GC15357@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593499619093217840?=
X-GMAIL-MSGID: =?utf-8?q?1593560847066776267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>=20
> mmap_min_addr handling is a bit mess... As you say, we would return
> EPERM rather than ENOMEM which can be confusing but depleting the
> address space like that is quite unlikely on 64b unless I am missing.
> It is good to be in sync here with the generic implementation though,
> IMO.
>=20

If we take a look on mm/mmap.c:
#ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
unsigned long
arch_get_unmapped_area_topdown(
=E2=80=A6
	if (len > TASK_SIZE - mmap_min_addr)
		return -ENOMEM;
=E2=80=A6
	info.low_limit =3D max(PAGE_SIZE, mmap_min_addr);

And this one looks like a generic implementation.
But for many other architectures like arch/parisc/kernel/sys_parisc.c=20
or arch/x86/kernel/sys_x86_64.c

	info.low_limit =3D PAGE_SIZE;

What is looks like an issue for me.

Here is C code could be used as test-case:

#include <errno.h>
#include <stdio.h>
#include <sys/mman.h>

int main() {
  char buffer[1024];

  unsigned long len =3D 1ULL << 46;
  while(len) {
    void *ptr =3D mmap(4096, len, 0, MAP_PRIVATE | MAP_ANONYMOUS , -1, =
0);
    if (ptr =3D=3D MAP_FAILED) {
      if (errno =3D=3D EPERM)
        break;
      if (errno =3D=3D ENOMEM) {
        len >>=3D 1;
        continue;
      }
      return -1;
    }
  }
  if (errno =3D=3D EPERM) {
    printf("Test failed, you have wrong ret code EPERM\n");
    sprintf(buffer, "cat /proc/%d/maps", getpid());
    system(buffer);
    return -1;
  }
  return 0;
}


>>=20
>> +	if (addr < mmap_min_addr)
>> +		return false;
>> +
>> 	return (addr > DEFAULT_MAP_WINDOW) =3D=3D (addr + len > =
DEFAULT_MAP_WINDOW);
>=20
> But is this one necessary? We do sanitze hint address before going to
> get_unmapped_address AFAIR.
>=20
I=E2=80=99m agree, looks like I was trying to fix something that already =
fine.

Thanks,
Ilya
