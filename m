Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/yHAdTCU//9JUAbuo4k/kM7FONmPD4DOIyCImbbvPA7AaWHwsf9wM5fCJRxMdO61Y+e+dI
ARC-Seal: i=1; a=rsa-sha256; t=1522707988; cv=none;
        d=google.com; s=arc-20160816;
        b=ux4F6JzPwPv27Kbd0Zo8dI48TKC+z1EXmlTXEi5nlL3+wtXbhiL/NXxNAP/o8fK0ah
         U7CyqF2dgyuz5cBhPQe7BVI180wrBWqLB/kiU08Vjb/ZGJ7QKstIihvOxcNaXp85BH2U
         9FCb1XAPM1V0cAsA+2dgxAGTDhijrJssVJbFtpOxkuUAkzsUSIpkrOjO4TglRlR5Ujlx
         niuI8aj0g8u/sZep9u1YJ4UmSJ1+wKBBCIenk38X7NbeN2M+/V2T6rpqw+Ety8Fq/l6r
         eCdxFZXtkM+zf2Y0IXOdwFgWwSaUEibU/vtuxG8ffrmLFH0UYxErkEXk97o8UzTVFWLH
         x87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=QozKXIA+KXio9wFE0imNfH6m8chywA3GytichCk+8tY=;
        b=CF4wV309U1QXWBDDZuElLodv42GR4iEaGP+TZP5Cp9TCmY6xovzAKO7Zl7azJcCyhY
         Hm4fSqVGpSGXDDaYsXje7l4wlRg2yOAPlwV/4KeiyDohp+hVTDe99JZb0d2x2O6tI92H
         jTSzYxzpGK75/WmxbzMXQjlV455LFmdvp0FCxm5viwOQO8p0UhsArpdNfsZeJ6r+G3wl
         F3awBMtuacCdQsTO58GSPDQc3Ma9ugDpxe5E99R563PKmi1+IXXWfZ8/I+sgtvGZzyYw
         bVgiM2HaiO4sRuLd98T7lLTly5OgVpDKcbBWc2otKCncUSy/XbH1iIMu5tIxDo/OW2By
         JI1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>
Date: Tue, 03 Apr 2018 08:26:15 +1000
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/17] staging: lustre: libcfs: discard cfs_time_shift().
In-Reply-To: <0B6A147C-7E98-4B00-AF32-AF8843484CF9@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760863.27689.4681198496926109808.stgit@noble> <alpine.LFD.2.21.1803302001440.9681@casper.infradead.org> <0B6A147C-7E98-4B00-AF32-AF8843484CF9@intel.com>
Message-ID: <87muyl1bzs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244842312934549?=
X-GMAIL-MSGID: =?utf-8?q?1596675051262996465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02 2018, Dilger, Andreas wrote:

>> On Mar 30, 2018, at 13:02, James Simmons <jsimmons@infradead.org> wrote:
>>=20
>>=20
>>> This function simply multiplies by HZ and adds jiffies.
>>> This is simple enough to be opencoded, and doing so
>>> makes the code easier to read.
>>>=20
>>> Same for cfs_time_shift_64()
>>=20
>> Reviewed-by: James Simmons <jsimmons@infradead.org>
>
> Hmm, I thought we were trying to get rid of direct HZ usage in modules,
> because of tickless systems, and move to e.g. msecs_to_jiffies() or simil=
ar?

Are we?  I hadn't heard but I could easily have missed it.
Documentation/scheduler/completion.txt does say

    Timeouts are preferably calculated with
    msecs_to_jiffies() or usecs_to_jiffies().

but is isn't clear what they are preferred to.  Do you remember where
you heard? or have a reference?

$ git grep ' \* *HZ'  |wc
   2244   15679  170016
$ git grep msecs_to_jiffies | wc
   3301   13151  276725

so msecs_to_jiffies is slightly more popular than "* HZ" (even if you add
in "HZ *").  But that could just be a preference for using milliseconds
over using seconds.

$ git grep msecs_to_jiffies   | grep -c '[0-9]000'
587

so there are only 587 places that msecs_to_jiffies is clearly used in
place of multiplying by HZ.

If we were to pursue this, I would want to add secs_to_jiffies() to
include/linux/jiffies.h and use that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrCrggACgkQOeye3VZi
gblbAQ//V+WKLCq3hb0nBpkm0IoqhnUaa4HVgZO9UsYdmv7gQm42v8GlIK41OxeH
NCdIwR4mWeTxGVnLPb1gxECHivFZeYQRrxoUJGDTiKN4CstKl3EMOD6jvSCAFPaX
2Z407pP5U+n6yJ55W4wKJWXJKrLF0V7hzOht6zMr3ON6hSbpiJYWo55LRcT9uJtR
TZfm7hSk2cgpRDOcN4Wh4Bjer71PGs/prbKA67EM7ubc83O6mXcs3qLfMAY5fRCl
rGA76CkScmLJj04xgGM6MsQeiQa77fdkWzzk959Jb2ZpbBPpKbDkFWX3FFlns6nz
w7oVp2CZWJqZsPp4xRJLcjXIRrDqiqBUUM+QObJ63y8yxo7esn0bwTHJrajc8WtA
1S1vrCEmIxTKq+vphi2L6Te2QpQphfyg2pcrDsI37yRsGEkOxLfcodVzK0a4JkOl
OjE/GcAQF87YOkoi7PW9MtRho/B4DFGL75AyJWAE96JzlY293ZgwcCDcuyyyDWQW
4NysgpttfHKIoBhCmrbGA0kvbPgrxYjsU0fr18AZmomre94XlveFxQNgA2tWqoM8
FccdLeKfBHaI74VRzvr5oHtewEg1dIHIEuLwqew/RKYqbXZeA19WKiqi3JFm84x8
D6pLu9jwTvKKDvUjh0yuzMe9mqlt2R2/2lCWJEQrcy09zIU6jhw=
=chdB
-----END PGP SIGNATURE-----
--=-=-=--
