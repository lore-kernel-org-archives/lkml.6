Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AG47ELumKAdZVId/62OzZYCVEkdTnYLUH0qnz0YsadTLmRsPy8uwZn7oqu46sf0Uojjo8qoEpzru
ARC-Seal: i=1; a=rsa-sha256; t=1521449459; cv=none;
        d=google.com; s=arc-20160816;
        b=hwTkvcjhoQw8gGCSA1SvjHOvWzzK085UpiYETbLiq5ZPVVysaQUK9023vvyYzgk0D4
         HKcoHJOZijPekUYjarKkWb43fCxovUI3ZdhMiZF91QnZNlutxilYbMF2RnhwWIvDPO/6
         uw1KlCrOysEXZv7h6VEDbKlmm8EhUIARj/iHp2CIl2LrrjC8mM7pUjHFKcIjDWQtvYw9
         cx7yUXTkp0IBkmRAi3ZOFDF9odp+XUSrjB9ZnOOWLO6af1UiVEsIgh20LESQFigSG7ol
         xnbBJr392olpqwWxlgPcvv4H8yKrk0tvUAnC7kkLdp9g1EUYf3CxTY3DnlnFlrJBDL4A
         bl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=icpguQugd2M+6N6+ScLH7dc4ehkc7Q6zUoTUjcaPJRk=;
        b=0Warx3tRcIC4CnJqVIhb6QnPOIg1il7/pZqn0mTDf46FvynKrjn+Jb3YcNkp3U2y96
         fqk9nFWFTpjIdLghzqE8+3CByQPiaj3Q6BKIydajjol89a0H8/7JuU9Gl53h+lkHa1LE
         rQyts6gKAXwoCI4Iz+m/usCxIhIZfnoKVdyDcFwrdm5YswXgpJjQbpHMw/dKj3Gen5JG
         U6joelv8OKrHdsjweZti6I2secFjF4t3UIENcAW0yzspvLp4dTOJVSurvs399HlMypKs
         t7fToUUPU3ZDLI7X0/v6EpOLGAQl7AzL9aG54QPmC1d0M/GoCclr+xOUKUYUtLikD3Hr
         34pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="asc'?scan'208";a="34982819"
From: Felipe Balbi <balbi@kernel.org>
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v.anuragkumar@gmail.com, APANDEY@xilinx.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Anurag Kumar Vulisha <anuragku@xilinx.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
In-Reply-To: <1521442253-15906-1-git-send-email-anuragku@xilinx.com>
References: <1521442253-15906-1-git-send-email-anuragku@xilinx.com>
Date: Mon, 19 Mar 2018 10:50:35 +0200
Message-ID: <87fu4wqwis.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595347861307192100?=
X-GMAIL-MSGID: =?utf-8?q?1595355388494136484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> This patch fixes two issues
>
> 1. The code logic in dwc3_prepare_one_trb() incorrectly uses the address
> and length given in req packet even for scattergather lists. This patch
> correct's the code to use sg->address and sg->length when scattergather
> lists are present.
>
> 2. The present code correctly fetches the req's which were not queued from
> the started_list but fails to start from the sg where it previously stopp=
ed
> queuing because of the unavailable TRB's. This patch correct's the code to
> start queuing from the correct sg in sglist.

these two should be in separate patches, then.

> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  drivers/usb/dwc3/core.h   |  4 ++++
>  drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 860d2bc..2779e58 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -718,7 +718,9 @@ struct dwc3_hwparams {
>   * @list: a list_head used for request queueing
>   * @dep: struct dwc3_ep owning this request
>   * @sg: pointer to first incomplete sg
> + * @sg_to_start: pointer to the sg which should be queued next
>   * @num_pending_sgs: counter to pending sgs
> + * @num_queued_sgs: counter to the number of sgs which already got queued

this is the same as num_pending_sgs.

>   * @remaining: amount of data remaining
>   * @epnum: endpoint number to which this request refers
>   * @trb: pointer to struct dwc3_trb
> @@ -734,8 +736,10 @@ struct dwc3_request {
>         struct list_head        list;
>         struct dwc3_ep          *dep;
>         struct scatterlist      *sg;
> +       struct scatterlist      *sg_to_start;

indeed, we seem to need something like this.

>         unsigned                num_pending_sgs;
> +       unsigned int            num_queued_sgs;

this should be unnecessary.

> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2bda4eb..1cffed5 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -978,11 +978,20 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *de=
p,
>                 struct dwc3_request *req, unsigned chain, unsigned node)
>  {
>         struct dwc3_trb         *trb;
> -       unsigned                length =3D req->request.length;
> +       unsigned int            length;
> +       dma_addr_t              dma;
>         unsigned                stream_id =3D req->request.stream_id;
>         unsigned                short_not_ok =3D req->request.short_not_o=
k;
>         unsigned                no_interrupt =3D req->request.no_interrup=
t;
> -       dma_addr_t              dma =3D req->request.dma;
> +
> +       if (req->request.num_sgs > 0) {
> +               /* Use scattergather list address and length */

unnecessary comment

> +               length =3D sg_dma_len(req->sg_to_start);
> +               dma =3D sg_dma_address(req->sg_to_start);
> +       } else {
> +               length =3D req->request.length;
> +               dma =3D req->request.dma;
> +       }
>
>         trb =3D &dep->trb_pool[dep->trb_enqueue];
>
> @@ -1048,11 +1057,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *de=
p)
>  static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
>                 struct dwc3_request *req)
>  {
> -       struct scatterlist *sg =3D req->sg;
> +       struct scatterlist *sg =3D req->sg_to_start;
>         struct scatterlist *s;
>         int             i;
>
> -       for_each_sg(sg, s, req->num_pending_sgs, i) {
> +       unsigned int remaining =3D req->request.num_mapped_sgs
> +               - req->num_queued_sgs;

already tracked as num_pending_sgs

> +       for_each_sg(sg, s, remaining, i) {
>                 unsigned int length =3D req->request.length;
>                 unsigned int maxp =3D usb_endpoint_maxp(dep->endpoint.des=
c);
>                 unsigned int rem =3D length % maxp;
> @@ -1081,6 +1093,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep=
 *dep,
>                         dwc3_prepare_one_trb(dep, req, chain, i);
>                 }
>
> +               /* In the case where not able to queue trbs for all sgs in

wrong comment style

> +                * request because of trb not available, update sg_to_sta=
rt
> +                * to next sg from which we can start queing trbs once tr=
bs
> +                * availbale
                     ^^^^^^^^^
                     available

sg_to_start is too long and awkward to type. Sure, I'm nitpicking, but
start_sg would be better.

> +                */
> +               if (chain)
> +                       req->sg_to_start =3D sg_next(s);
> +
> +               req->num_queued_sgs++;
> +
>                 if (!dwc3_calc_trbs_left(dep))
>                         break;
>         }
> @@ -1171,6 +1193,8 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
>                         return;
>
>                 req->sg                 =3D req->request.sg;
> +               req->sg_to_start        =3D req->sg;
> +               req->num_queued_sgs     =3D 0;

num_queued_sgs is unnecessary.

>                 req->num_pending_sgs    =3D req->request.num_mapped_sgs;
>
>                 if (req->num_pending_sgs > 0)
> @@ -2327,8 +2351,14 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc=
, struct dwc3_ep *dep,
>
>                 req->request.actual =3D length - req->remaining;
>
> -               if ((req->request.actual < length) && req->num_pending_sg=
s)
> -                       return __dwc3_gadget_kick_transfer(dep);
> +               if (req->request.actual < length || req->num_pending_sgs)=
 {

why do you think this needs to be || instead of &&? If actual =3D=3D length
we're done, there's nothing more left to do. If there is either host
sent more data than it should, or we miscalculated num_pending_sgs, or
we had the wrong length somewhere in some TRBs. Either of those cases is
an error condition we don't want to hide. We want things to fail in that
case.

> +                       /* There could be cases where the whole req can't=
 be

wrong comment style.

> +                        * mapped into TRB's available. In that case, we =
need
> +                        * to kick transfer again if (req->num_pending_sg=
s > 0)
> +                        */

also, the code has already been trying to do that. It just wasn't
correct. We don't need to add this comment.

> +                       if (req->num_pending_sgs)
> +                               return __dwc3_gadget_kick_transfer(dep);

another num_pending_sgs check? Why?

> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you
> are not the intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message and any
> attachments immediately.

I can't accept ANY patches from you until you remove this footer. In
fact, I'm not in the To field, so I'm not a "named recipient" and
therefore, I'm deleting your email. Talk to your IT department about
contributing to public mailing lists.

Email, now, deleted.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqvedsACgkQzL64meEa
mQamnRAAjaJL/CG6ZSwA4Xttd9TO94I2YnVp+4c+5kdrXPMU7C31XUU+QD+swmWb
NGCWAgtsAaqXRLsDUH9YAQkVx4d4y94Xo3fFWEWHO8bUvwdqG2rUPD2k1BZJomaN
XL6f2fSMwMgpWQQwvVpuneeVrcgqzUDyJQIKDhB+JCjHpLqA3RPJy1QeaL6O/jjs
xTSBU2WF67mCJErS3jSaIEr44bNV4tMpKcSaXCewTgLekt1fJE8icAgcyrnx4vS3
gUvViRX3Zep9sepbYt6GQOA1PfI9sNHCq+An2ng888Poh2ZVvpwZH06cL4Sgwv2m
fLFiAQBfsul0+vseJtTCT9tT1YVLpR/JV2VfTrGiwUC+71GPQIIwWHlAdAUt8ekG
mpQGwgOtyteaHJSrft96F8DPHH0w0nPhR4tTKWGmHJ2UzVSOJvFVA4xQmbp/46jz
Amv9HVJUveUCnAtS4Ci/7inDw0vavs0WTXZvnsGdZA9oxJHzkBt6lmQzjfeHqKfU
odqK56nupFs6CmQ/boQjoqBxAWpkBQFVO/4Pd6I4ov4Ehe/JmM+88oaFoTX0O30p
QaeyXLBhIjuTZ5NBUNaU3CAFoSE1H4NLigNmnJbxUS7FWLN3+iBPxzNUujp1qecI
hOxpX9tYjoCi7DCRVVEEc6SY6TV+L9mdEoTR9599dHvRp0pVAEc=
=5+rz
-----END PGP SIGNATURE-----
--=-=-=--
