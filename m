Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519329548; cv=none;
        d=google.com; s=arc-20160816;
        b=lV+dHUtM2jNVZsxAyPN6CTkpOsAWGe721Eky/Q/0dJH+2GRyyxaqVq/zt9MJS5LIWi
         mxwuqOQp7IePzx0Tl9feWvefsXN22ssrsgLEURY/DrgGxd9yBQbc2yM1VRsaMS2KD3Og
         77q9szwbN32Lo8dthUuH7USGLMRyQpr4SenXj1NOfISwyZFjAKhO5ID7bRdugZQSQIfM
         p9LrgThlj4pURPRgzXhcNh0lijQdw1ojHepAgLD1eADA/J2RTi1fJcCPXhj+RebDuCwa
         jVe7oblL4sYK9gidYdJw36JNlcyhi8qVVyKzsI8r5kwFcc8iJs+E5SxxwOWY/kG4WHyT
         fXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=D8XH7dRITFlWJLepshuDLUyHukHEDgWFDWb3NlqpmF4=;
        b=Bj6C8sSSeAw3W7pAeuTRaJ5id8NDMcP1uVl/4jAJD3u9pzVjWX0mHR4Gq/lJkqY6Ra
         JhESQEMr4iCj6U23akjgrFs5qrF46ZxXsGExXg6KS0SISt2DipbxzJN5keZ9u/ncxInL
         zPyLZOScQbDBiwdjCwFBtnfx0Can5tsFdVTpXSEyaoG9nepp6cIxdqZS3IYzyP51f2vW
         WS75cngeAl/dcs7nFJxWuvun9sVrdmxhWOa5eEBbpV90Kls3KZtwB29lYvjNqXbEs3/V
         7jYNMmLBuM0KzeKULbot7mWej/fni4mxMZSuiMsbPTvkSZlFXrcRojgTknja/Py8QXEB
         YpYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hosAeHsk;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hosAeHsk;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsXvj9vsLc3TPeJRuwyg70p1iSiM7JOQENzfjStlEtXB/cdiPGl2brXmMf2rtNtH2sXl7dOFf4Rb1TXIaEDpPg=
MIME-Version: 1.0
References: <20180216190201.59572-1-joelaf@google.com> <20180222134832.GA1400@kroah.com>
In-Reply-To: <20180222134832.GA1400@kroah.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Feb 2018 19:58:56 +0000
Message-ID: <CAJWu+oqd=B8FHeWnuLYp1H3Fz1oT9v8z+Gq6SA+Dkg=OYbyjrw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ashmem: Fix lockdep issue during llseek
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Arve Hjonnevag <arve@android.com>, Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c07e654f458ef0565d2798a"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593132500003855945?=
X-GMAIL-MSGID: =?utf-8?q?1593132500003855945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c07e654f458ef0565d2798a
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 22, 2018 at 5:48 AM, Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:
>> ashmem_mutex create a chain of dependencies like so:
>>
>> (1)
>> mmap syscall ->
>>   mmap_sem ->  (acquired)
>>   ashmem_mmap
>>   ashmem_mutex (try to acquire)
>>   (block)
>>
>> (2)
>> llseek syscall ->
>>   ashmem_llseek ->
>>   ashmem_mutex ->  (acquired)
>>   inode_lock ->
>>   inode->i_rwsem (try to acquire)
>>   (block)
>>
>> (3)
>> getdents ->
>>   iterate_dir ->
>>   inode_lock ->
>>   inode->i_rwsem   (acquired)
>>   copy_to_user ->
>>   mmap_sem         (try to acquire)
>>
>> There is a lock ordering created between mmap_sem and inode->i_rwsem
>> causing a lockdep splat [2] during a syzcaller test, this patch fixes
>> the issue by unlocking the mutex earlier. Functionally that's Ok since
>> we don't need to protect vfs_llseek.
>>
>> [1] https://patchwork.kernel.org/patch/10185031/
>> [2] https://lkml.org/lkml/2018/1/10/48
>>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Arve Hjonnevag <arve@android.com>
>> Cc: Greg Hackmann <ghackmann@google.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> ---
>> Changes since first version:
>> Don't relock after vfs call since its not needed. Only reason we lock is
>> to protect races with asma->file.
>> https://patchwork.kernel.org/patch/10185031/
>
> I'd like some acks from others before I take this patch.

GregH, Todd, could you provide Acks?

>
> Joel, did the original reporter say this patch solved their issue or
> not?  For some reason I didn't think it worked properly...

That's a different but similar issue:
https://patchwork.kernel.org/patch/10202127/. That was related to
RECLAIM_FS lockdep recursion. That was posted as an RFC unlike this one,
and its still being investigated since Miles reported that the lockdep
inode annotation doesn't fix the issue.

This one on the other hand has a straightforward fix, and was verified by
the syzbot.

I can see why its easy to confuse the two issues.

Thanks,

- Joel

>
> thanks,
>
> greg k-h

--94eb2c07e654f458ef0565d2798a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br>
<br>
On Thu, Feb 22, 2018 at 5:48 AM, Greg Kroah-Hartman &lt;<a href=3D"mailto:g=
regkh@linuxfoundation.org" target=3D"_blank" rel=3D"noreferrer">gregkh@linu=
xfoundation.org</a>&gt; wrote:<br>
&gt; On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:<br>
&gt;&gt; ashmem_mutex create a chain of dependencies like so:<br>
&gt;&gt;<br>
&gt;&gt; (1)<br>
&gt;&gt; mmap syscall -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0mmap_sem -&gt;=C2=A0 (acquired)<br>
&gt;&gt;=C2=A0 =C2=A0ashmem_mmap<br>
&gt;&gt;=C2=A0 =C2=A0ashmem_mutex (try to acquire)<br>
&gt;&gt;=C2=A0 =C2=A0(block)<br>
&gt;&gt;<br>
&gt;&gt; (2)<br>
&gt;&gt; llseek syscall -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0ashmem_llseek -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0ashmem_mutex -&gt;=C2=A0 (acquired)<br>
&gt;&gt;=C2=A0 =C2=A0inode_lock -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0inode-&gt;i_rwsem (try to acquire)<br>
&gt;&gt;=C2=A0 =C2=A0(block)<br>
&gt;&gt;<br>
&gt;&gt; (3)<br>
&gt;&gt; getdents -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0iterate_dir -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0inode_lock -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0inode-&gt;i_rwsem=C2=A0 =C2=A0(acquired)<br>
&gt;&gt;=C2=A0 =C2=A0copy_to_user -&gt;<br>
&gt;&gt;=C2=A0 =C2=A0mmap_sem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(try to acqu=
ire)<br>
&gt;&gt;<br>
&gt;&gt; There is a lock ordering created between mmap_sem and inode-&gt;i_=
rwsem<br>
&gt;&gt; causing a lockdep splat [2] during a syzcaller test, this patch fi=
xes<br>
&gt;&gt; the issue by unlocking the mutex earlier. Functionally that&#39;s =
Ok since<br>
&gt;&gt; we don&#39;t need to protect vfs_llseek.<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://patchwork.kernel.org/patch/10185031/" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://patchwork.kernel.org/p=
atch/10185031/</a><br>
&gt;&gt; [2] <a href=3D"https://lkml.org/lkml/2018/1/10/48" rel=3D"noreferr=
er noreferrer" target=3D"_blank">https://lkml.org/lkml/2018/1/10/48</a><br>
&gt;&gt;<br>
&gt;&gt; Cc: Todd Kjos &lt;<a href=3D"mailto:tkjos@google.com" target=3D"_b=
lank" rel=3D"noreferrer">tkjos@google.com</a>&gt;<br>
&gt;&gt; Cc: Arve Hjonnevag &lt;<a href=3D"mailto:arve@android.com" target=
=3D"_blank" rel=3D"noreferrer">arve@android.com</a>&gt;<br>
&gt;&gt; Cc: Greg Hackmann &lt;<a href=3D"mailto:ghackmann@google.com" targ=
et=3D"_blank" rel=3D"noreferrer">ghackmann@google.com</a>&gt;<br>
&gt;&gt; Cc: Greg Kroah-Hartman &lt;<a href=3D"mailto:gregkh@linuxfoundatio=
n.org" target=3D"_blank" rel=3D"noreferrer">gregkh@linuxfoundation.org</a>&=
gt;<br>
&gt;&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" re=
l=3D"noreferrer">stable@vger.kernel.org</a><br>
&gt;&gt; Reported-by: <a href=3D"mailto:syzbot%2B8ec30bb7bf1a981a2012@syzka=
ller.appspotmail.com" target=3D"_blank" rel=3D"noreferrer">syzbot+8ec30bb7b=
f1a981a2012@syzkaller.appspotmail.com</a><br>
&gt;&gt; Signed-off-by: Joel Fernandes &lt;<a href=3D"mailto:joelaf@google.=
com" target=3D"_blank" rel=3D"noreferrer">joelaf@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; Changes since first version:<br>
&gt;&gt; Don&#39;t relock after vfs call since its not needed. Only reason =
we lock is<br>
&gt;&gt; to protect races with asma-&gt;file.<br>
&gt;&gt; <a href=3D"https://patchwork.kernel.org/patch/10185031/" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://patchwork.kernel.org/patch/1=
0185031/</a><br>
&gt;<br>
&gt; I&#39;d like some acks from others before I take this patch.<br>
<br>
GregH, Todd, could you provide Acks?<br>
<br>
&gt;<br>
&gt; Joel, did the original reporter say this patch solved their issue or<b=
r>
&gt; not?=C2=A0 For some reason I didn&#39;t think it worked properly...<br=
>
<br>
That&#39;s a different but similar issue: <a href=3D"https://patchwork.kern=
el.org/patch/10202127/" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
ps://patchwork.kernel.org/patch/10202127/</a>. That was related to RECLAIM_=
FS lockdep recursion. That was posted as an RFC unlike this one, and its st=
ill being investigated since Miles reported that the lockdep inode annotati=
on doesn&#39;t fix the issue.<br>
<br>
This one on the other hand has a straightforward fix, and was verified by t=
he syzbot.<div dir=3D"auto"><br></div><div dir=3D"auto">I can see why its e=
asy to confuse the two issues.<br>
<br>Thanks,</div><div dir=3D"auto"><br>
- Joel<br>
<br>
&gt;<br>
&gt; thanks,<br>
&gt;<br>
&gt; greg k-h<br></div></div>

--94eb2c07e654f458ef0565d2798a--
