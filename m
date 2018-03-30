Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522373944; cv=none;
        d=google.com; s=arc-20160816;
        b=k550c6l5kvDQLrj7dpZqQr58w8P4Y/gH1fEnrlEpIdsISv4X05RBynmTO+82edEjV9
         9Dce1PAtTCn73lmTzuHmnG/vF3Emz24cDz0SGPaz/8Aet449cb0lL6Tu0w18t2u8B3yt
         9UR2PCbTRr1y+rsXyOfRDUCavXIZTurgXNsnUF1FwLj0zv4qGWDUTOnT3aR/Oz66s1fW
         CspREDjs5WK77IHOWThUCWTwpCImtjxDgzoHs9gbvFbx0JYWnt43Y44k0BHOs8f9EtBz
         6kjbpxb3IMZ3NYU1l/mHvlExaMu/AVyveyr53OsN1/GHoM20KkB3D/tzisu8GiAfgSFS
         o2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cJF/KlIP2Znzrqew5cfnvQTsMWEQykAKfrA0VahZ38k=;
        b=MhVJ6XVpKlYqLHLaJkKyNA0dAyTrZyh8jDTnuei5/uxXEuwTClo5V5LNZteiwte9BR
         xolCURKbExexBycbZeYaW8iuRpkIKdXBxSNaOdaB3YLldeXN0jb9QZQVDNT0c/dT+ugb
         Z8eQazM/iI7I3zuV0f9UCqR0KGVu6cbDmxkWK83DH1zJb56+b3iPipFqRRf5WN0XpyIX
         mNI6uS4HsRFXNSgbvxW/Cq0KbCjNPuHyhMcozXcES0kETibT27zlPtHrO7QABzZG3UO9
         V2BQBEbBA2DDRf28ejfU2c8m7OhYIWl+PJyRwNm8Iy3VhJOiR9uIIQkdxMKta4GEuxK/
         DM2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DhkF+GNB;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DhkF+GNB;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx484x6D6kOQXJlgliHpp9qrbPS0AdM6N7g4CfLlLKmirYO/i2xxQYR4sBtCFn3SoKhGvTMGfO52LwzADQ1IdYHw=
MIME-Version: 1.0
In-Reply-To: <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org> <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Fri, 30 Mar 2018 09:39:03 +0800
Message-ID: <CADAEsF_B2Jt=OQetHLKqfSq=wU4SSzQYtTLjYExiS9a09na6zA@mail.gmail.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596324780681462836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-30 9:29 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> Hi Ganesh,
>
> On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
>> 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> > binder_update_page_range needs down_write of mmap_sem because
>> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
>> > it is set. However, when I profile binder working, it seems
>> > every binder buffers should be mapped in advance by binder_mmap.
>> > It means we could set VM_MIXEDMAP in binder_mmap time which is
>> > already hold a mmap_sem as down_write so binder_update_page_range
>> > doesn't need to hold a mmap_sem as down_write.
>> >
>> > Android suffers from mmap_sem contention so let's reduce mmap_sem
>> > down_write.
>>
>> Hi, Minchan:
>>
>> It seems there is performance regression of this patch.
>
> You mean "This patch aims for solving performance regression" not "This patch
> makes performance regression"?

After applying this patch in our devices, app launch time increases
about 15% in average.
"This patch makes performance regression", yes, from the results, it
is like this.

I will do more test of this patch.

>
>>
>> Do you have some test result of android app launch time or binderThroughput?
>
> Unfortunately, I don't have any number. The goal is to reduce the number of
> call mmap_sem as write-side lock because it makes priority inversion of threads
> easily and that's one of clear part I spot that we don't need write-side lock.
>
> Thanks.
