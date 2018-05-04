Return-Path: <kjlu@umn.edu>
X-Google-Smtp-Source: AB8JxZrgSfqWgsVFzTzmC3gFqeMnYM7zudkroDSm4U3qBRNfSwteEpa2yHiqrk2+p83/6+YSsbff
ARC-Seal: i=1; a=rsa-sha256; t=1525446107; cv=none;
        d=google.com; s=arc-20160816;
        b=a1qvLGDnRitE94bi3/AS4MQmoslcH8LPdSPt8N/lVMWBdazhS1RaVkw1A9YmvEuHYF
         YZEnaOjY1/S/U39YiVhrQ1D2WMARKA4U8gSMh2cHqeBhpyz4WkslWyPe3TuAufX3rxDT
         ehKzmAKB4oRAFUjNgjZlzuI4g8YmYvc1TlEf2/JW0yBMyhFoyZvFX7WdXZNool1aFKMY
         1nHv1ivCFxNL03PzydTJ4gzpuPjmbsIp1/bW5kUyhTn0sumpICnUa/BkiBqZkvdGJH5o
         ZkEtCgoUt3GMuAhC9LyId3hIu/ktbcFHS9wtZstKmX175XrTigc8egtES3MDJbCQqdds
         Wxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=FMEvn+6rj+0J6Cex/4qn/0KBV9g4C4DhI3QSUnj1+6A=;
        b=DCcJ9+m2zF8bTtUFbfJ9NuOq8NI9td1l3IsCpgG6MJbAbKggavIEYgdyw4vgMMj2h7
         7LQS6mkHm7QJQEGgGD0rvQw2LBLrSLyJZ3R16rVhyL0VM0DuwmQopWcKIewwJD4zchOA
         LoSigLVrWvOz8uv2nBSYQOnZc1k5KBcPFjzKlOkVuG3YNBsTvYJ0J8gruz+Jmw8L03IP
         hgrTDHTJRL18qg4zgMwsc+T3bd/I63sE1e7pCnnhKDBYMJmLaoORrANm82O0Rn0UTD+N
         n027q1vbTK3pu7LFgDBL0+pEFIkCziaDBUxrBgb3h/CVvAfKiLZ/WlpW+4PvN5hRKntO
         wKJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=R2bsmuAg;
       spf=pass (google.com: domain of kjlu@umn.edu designates 134.84.196.205 as permitted sender) smtp.mailfrom=kjlu@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=R2bsmuAg;
       spf=pass (google.com: domain of kjlu@umn.edu designates 134.84.196.205 as permitted sender) smtp.mailfrom=kjlu@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
MIME-Version: 1.0
From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 4 May 2018 10:01:44 -0500
Message-ID: <CAK8Kejq0h_Rgq__W_KSD_u+KUbS=cYkVXoHJpdbDrmYOU+iJDg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
To: "Dilger, Andreas" <andreas.dilger@intel.com>
Cc: Wenwen Wang <wang6495@umn.edu>, Dan Carpenter <dan.carpenter@oracle.com>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Aastha Gupta <aastha.gupta4104@gmail.com>,
	Roman Storozhenko <romeusmeister@gmail.com>, Jeff Layton <jlayton@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
	open list <linux-kernel@vger.kernel.org>, "Drokin, Oleg" <oleg.drokin@intel.com>,
	"moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM" <lustre-devel@lists.lustre.org>
Content-Type: multipart/alternative; boundary="0000000000003d96be056b6299fc"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599213662406091322?=
X-GMAIL-MSGID: =?utf-8?q?1599546178232494150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000003d96be056b6299fc
Content-Type: text/plain; charset="UTF-8"

On Fri, May 4, 2018 at 5:08 AM, Dilger, Andreas <andreas.dilger@intel.com>
wrote:

> On May 3, 2018, at 22:19, Wenwen Wang <wang6495@umn.edu> wrote:
> >
> > On Tue, May 1, 2018 at 3:46 AM, Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> >> On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:
> >>> However, given that the user data resides in the user space, a
> malicious
> >>> user-space process can race to change the data between the two copies.
> By
> >>> doing so, the attacker can provide a data with an inconsistent version,
> >>> e.g., v1 version + v3 data. This can lead to logical errors in the
> >>> following execution in ll_dir_setstripe(), which performs different
> actions
> >>> according to the version specified by the field lmm_magic.
> >>
> >> This part is misleading.  The fix is to improve readability and make
> >> static checkers happy.  You're over dramatizing it to make people think
> >> it has a security impact when it doesn't.
> >>
> >> If the user wants to specify v1 data they can just say that on the first
> >> read.  They don't need to do funny tricks and race between the two
> >> reads.  It's allowed.
> >>
> >> In other words this allows the user to do something in a very
> >> complicated way which they are already allowed to do in a very simple
> >> straight forward way.
> >>
> >> regards,
> >> dan carpenter
> >
> > Thanks for your comment, Dan! How about this:
> >
> > However, given that the user data resides in the user space, a
> > malicious user-space process can race to change the data between the
> > two copies. By doing so, the attacker can provide a data with an
> > inconsistent version, e.g., v1 version + v3 data. The current kernel
> > can handle such inconsistent data. But, it may pose a potential
> > security risk for future implementations. Also, to improve code
> > readability and make static analysis tools happy, which will warn
> > about read-verify-re-read type bugs, this issue should be fixed.
>
> There is nothing preventing the user from using struct lov_mds_md_v3 but
> filling in lmm_magic = LOV_MAGIC_V1 from the beginning, no need for a race.
>

Right. No need for users to race. There might be a type confusion issue
though if V1
object is  used as V3 or the other way.


>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation
>
>
>
>
>
>
>
>


-- 
Kangjie Lu
Assistant Professor
Department of Computer Science and Engineering
University of Minnesota
kjlu@umn.edu
http://kangjie.lu

--0000000000003d96be056b6299fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, May 4, 2018 at 5:08 AM, Dilger, Andreas <span dir=3D"ltr">&lt;<=
a href=3D"mailto:andreas.dilger@intel.com" target=3D"_blank">andreas.dilger=
@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"HOEnZb"><div class=3D"h5">On May 3, 2018, at 22:19, Wenwen Wang &lt;<=
a href=3D"mailto:wang6495@umn.edu">wang6495@umn.edu</a>&gt; wrote:<br>
&gt; <br>
&gt; On Tue, May 1, 2018 at 3:46 AM, Dan Carpenter &lt;<a href=3D"mailto:da=
n.carpenter@oracle.com">dan.carpenter@oracle.com</a>&gt; wrote:<br>
&gt;&gt; On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:<br>
&gt;&gt;&gt; However, given that the user data resides in the user space, a=
 malicious<br>
&gt;&gt;&gt; user-space process can race to change the data between the two=
 copies. By<br>
&gt;&gt;&gt; doing so, the attacker can provide a data with an inconsistent=
 version,<br>
&gt;&gt;&gt; e.g., v1 version + v3 data. This can lead to logical errors in=
 the<br>
&gt;&gt;&gt; following execution in ll_dir_setstripe(), which performs diff=
erent actions<br>
&gt;&gt;&gt; according to the version specified by the field lmm_magic.<br>
&gt;&gt; <br>
&gt;&gt; This part is misleading.=C2=A0 The fix is to improve readability a=
nd make<br>
&gt;&gt; static checkers happy.=C2=A0 You&#39;re over dramatizing it to mak=
e people think<br>
&gt;&gt; it has a security impact when it doesn&#39;t.<br>
&gt;&gt; <br>
&gt;&gt; If the user wants to specify v1 data they can just say that on the=
 first<br>
&gt;&gt; read.=C2=A0 They don&#39;t need to do funny tricks and race betwee=
n the two<br>
&gt;&gt; reads.=C2=A0 It&#39;s allowed.<br>
&gt;&gt; <br>
&gt;&gt; In other words this allows the user to do something in a very<br>
&gt;&gt; complicated way which they are already allowed to do in a very sim=
ple<br>
&gt;&gt; straight forward way.<br>
&gt;&gt; <br>
&gt;&gt; regards,<br>
&gt;&gt; dan carpenter<br>
&gt; <br>
&gt; Thanks for your comment, Dan! How about this:<br>
&gt; <br>
&gt; However, given that the user data resides in the user space, a<br>
&gt; malicious user-space process can race to change the data between the<b=
r>
&gt; two copies. By doing so, the attacker can provide a data with an<br>
&gt; inconsistent version, e.g., v1 version + v3 data. The current kernel<b=
r>
&gt; can handle such inconsistent data. But, it may pose a potential<br>
&gt; security risk for future implementations. Also, to improve code<br>
&gt; readability and make static analysis tools happy, which will warn<br>
&gt; about read-verify-re-read type bugs, this issue should be fixed.<br>
<br>
</div></div>There is nothing preventing the user from using struct lov_mds_=
md_v3 but<br>
filling in lmm_magic =3D LOV_MAGIC_V1 from the beginning, no need for a rac=
e.<br></blockquote><div><br></div><div>Right. No need for users to race. Th=
ere might be a type confusion issue though if V1</div><div>object is=C2=A0 =
used as V3 or the other way.=C2=A0</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
Cheers, Andreas<br>
--<br>
Andreas Dilger<br>
Lustre Principal Architect<br>
Intel Corporation<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><span style=3D"font-size:12.8px">Kangji=
e Lu</span><br></div><div>Assistant Professor</div><div>Department of Compu=
ter Science and Engineering</div><div>University of Minnesota</div><div><a =
href=3D"mailto:kjlu@umn.edu" target=3D"_blank">kjlu@umn.edu</a></div><div><=
a href=3D"http://kangjie.lu" target=3D"_blank">http://kangjie.lu</a></div><=
/div></div></div></div>
</div></div>

--0000000000003d96be056b6299fc--
