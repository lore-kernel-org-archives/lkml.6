Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D3AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83537273CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83537273CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965637AbeF1NHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:07:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:47355 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965127AbeF1NHl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 28 Jun 2018 09:07:41 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 28 Jun 2018 15:07:33 +0200
Date:   Thu, 28 Jun 2018 21:07:20 +0800
From:   joeyli <jlee@suse.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/3][RFC] PM / Hibernate: Encrypt the snapshot pages
 before submitted to the block device
Message-ID: <20180628130641.GG3628@linux-l9pv.suse>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On Wed, Jun 20, 2018 at 05:40:32PM +0800, Chen Yu wrote:
> Use the helper functions introduced previously to encrypt
> the page data before they are submitted to the block device.
> Besides, for the case of hibernation compression, the data
> are firstly compressed and then encrypted, and vice versa
> for the resume process.
>

I want to suggest my solution that it direct signs/encrypts the
memory snapshot image. This solution is already shipped with
SLE12 a couple of years:

https://github.com/joeyli/linux-s4sign/commits/s4sign-hmac-encrypted-key-v0.2-v4.17-rc3

The above patches still need to clean up. I am working on some
other bugs, but I can clean up and send out it ASAP.

The advantage of this solution is that it produces a signed and
encrypted image. Not just for writing to block device by kernel,
it also can provide a signed/encrypted image to user space. User
space can store the encrypted image to anywhere.

I am OK for your user space key generator because I didn't have
similar solution yet. I am working on the EFI master key and also
want to adapt hibernation to keyring. I will continue the works.

Thanks a lot!
Joey Lee
 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/power.h |   1 +
>  kernel/power/swap.c  | 215 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 205 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 660aac3..637695c 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -207,6 +207,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_PLATFORM_MODE	1
>  #define SF_NOCOMPRESS_MODE	2
>  #define SF_CRC32_MODE	        4
> +#define SF_ENCRYPT_MODE		8
>  
>  /* kernel/power/hibernate.c */
>  extern int swsusp_check(void);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c2bcf97..2b6b3d0 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -102,14 +102,16 @@ struct swap_map_handle {
>  	unsigned int k;
>  	unsigned long reqd_free_pages;
>  	u32 crc32;
> +	bool crypto;
>  };
>  
>  struct swsusp_header {
>  	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
> -	              sizeof(u32)];
> +			sizeof(u32) - HIBERNATE_SALT_BYTES];
>  	u32	crc32;
>  	sector_t image;
>  	unsigned int flags;	/* Flags to pass to the "boot" kernel */
> +	char salt[HIBERNATE_SALT_BYTES];
>  	char	orig_sig[10];
>  	char	sig[10];
>  } __packed;
> @@ -127,6 +129,53 @@ struct swsusp_extent {
>  	unsigned long end;
>  };
>  
> +/* For encryption/decryption. */
> +static struct hibernation_crypto *hibernation_crypto_ops;
> +
> +void set_hibernation_ops(struct hibernation_crypto *ops)
> +{
> +	hibernation_crypto_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(set_hibernation_ops);
> +
> +static int crypto_data(const char *inbuf,
> +			    int inlen,
> +			    char *outbuf,
> +			    int outlen,
> +			    bool encrypt,
> +			    int page_idx)
> +{
> +	if (hibernation_crypto_ops &&
> +	    hibernation_crypto_ops->crypto_data)
> +		return hibernation_crypto_ops->crypto_data(inbuf,
> +			inlen, outbuf, outlen, encrypt, page_idx);
> +	else
> +		return -EINVAL;
> +}
> +
> +static void crypto_save(void *outbuf)
> +{
> +	if (hibernation_crypto_ops &&
> +	    hibernation_crypto_ops->save)
> +		hibernation_crypto_ops->save(outbuf);
> +}
> +
> +static void crypto_restore(void *inbuf)
> +{
> +	if (hibernation_crypto_ops &&
> +	    hibernation_crypto_ops->restore)
> +		hibernation_crypto_ops->restore(inbuf);
> +}
> +
> +static int crypto_init(bool suspend)
> +{
> +	if (hibernation_crypto_ops &&
> +	    hibernation_crypto_ops->init)
> +		return hibernation_crypto_ops->init(suspend);
> +	else
> +		return -EINVAL;
> +}
> +
>  static struct rb_root swsusp_extents = RB_ROOT;
>  
>  static int swsusp_extents_insert(unsigned long swap_offset)
> @@ -318,6 +367,10 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>  		swsusp_header->flags = flags;
>  		if (flags & SF_CRC32_MODE)
>  			swsusp_header->crc32 = handle->crc32;
> +		if (handle->crypto) {
> +			swsusp_header->flags |= SF_ENCRYPT_MODE;
> +			crypto_save((void *)swsusp_header->salt);
> +		}
>  		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
>  				      swsusp_resume_block, swsusp_header, NULL);
>  	} else {
> @@ -535,11 +588,12 @@ static int save_image(struct swap_map_handle *handle,
>  {
>  	unsigned int m;
>  	int ret;
> -	int nr_pages;
> +	int nr_pages, crypto_page_idx;
>  	int err2;
>  	struct hib_bio_batch hb;
>  	ktime_t start;
>  	ktime_t stop;
> +	void *tmp = NULL, *crypt_buf = NULL;
>  
>  	hib_init_batch(&hb);
>  
> @@ -549,12 +603,33 @@ static int save_image(struct swap_map_handle *handle,
>  	if (!m)
>  		m = 1;
>  	nr_pages = 0;
> +	crypto_page_idx = 0;
> +	if (handle->crypto) {
> +		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
> +		if (!crypt_buf)
> +			return -ENOMEM;
> +	}
> +
>  	start = ktime_get();
>  	while (1) {
>  		ret = snapshot_read_next(snapshot);
>  		if (ret <= 0)
>  			break;
> -		ret = swap_write_page(handle, data_of(*snapshot), &hb);
> +		tmp = data_of(*snapshot);
> +		if (handle->crypto) {
> +			/* Encryption before submit_io.*/
> +			ret = crypto_data(data_of(*snapshot),
> +					  PAGE_SIZE,
> +					  crypt_buf,
> +					  PAGE_SIZE,
> +					  true,
> +					  crypto_page_idx);
> +			if (ret)
> +				goto out;
> +			crypto_page_idx++;
> +			tmp = crypt_buf;
> +		}
> +		ret = swap_write_page(handle, tmp, &hb);
>  		if (ret)
>  			break;
>  		if (!(nr_pages % m))
> @@ -569,6 +644,9 @@ static int save_image(struct swap_map_handle *handle,
>  	if (!ret)
>  		pr_info("Image saving done\n");
>  	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
> + out:
> +	if (crypt_buf)
> +		free_page((unsigned long)crypt_buf);
>  	return ret;
>  }
>  
> @@ -671,7 +749,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>  {
>  	unsigned int m;
>  	int ret = 0;
> -	int nr_pages;
> +	int nr_pages, crypto_page_idx;
>  	int err2;
>  	struct hib_bio_batch hb;
>  	ktime_t start;
> @@ -767,6 +845,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>  	if (!m)
>  		m = 1;
>  	nr_pages = 0;
> +	crypto_page_idx = 0;
>  	start = ktime_get();
>  	for (;;) {
>  		for (thr = 0; thr < nr_threads; thr++) {
> @@ -835,7 +914,25 @@ static int save_image_lzo(struct swap_map_handle *handle,
>  			for (off = 0;
>  			     off < LZO_HEADER + data[thr].cmp_len;
>  			     off += PAGE_SIZE) {
> -				memcpy(page, data[thr].cmp + off, PAGE_SIZE);
> +				if (handle->crypto) {
> +					/*
> +					 * Encrypt the compressed data
> +					 * before we write them to the
> +					 * block device.
> +					 */
> +					ret = crypto_data(data[thr].cmp + off,
> +							  PAGE_SIZE,
> +							  page,
> +							  PAGE_SIZE,
> +							  true,
> +							  crypto_page_idx);
> +					if (ret)
> +						goto out_finish;
> +					crypto_page_idx++;
> +				} else {
> +					memcpy(page, data[thr].cmp + off,
> +						PAGE_SIZE);
> +				}
>  
>  				ret = swap_write_page(handle, page, &hb);
>  				if (ret)
> @@ -909,6 +1006,7 @@ int swsusp_write(unsigned int flags)
>  	int error;
>  
>  	pages = snapshot_get_image_size();
> +	memset(&handle, 0, sizeof(struct swap_map_handle));
>  	error = get_swap_writer(&handle);
>  	if (error) {
>  		pr_err("Cannot get swap writer\n");
> @@ -922,6 +1020,9 @@ int swsusp_write(unsigned int flags)
>  		}
>  	}
>  	memset(&snapshot, 0, sizeof(struct snapshot_handle));
> +	if (!crypto_init(true))
> +		/* The image needs to be encrypted. */
> +		handle.crypto = true;
>  	error = snapshot_read_next(&snapshot);
>  	if (error < PAGE_SIZE) {
>  		if (error >= 0)
> @@ -1059,7 +1160,8 @@ static int load_image(struct swap_map_handle *handle,
>  	ktime_t stop;
>  	struct hib_bio_batch hb;
>  	int err2;
> -	unsigned nr_pages;
> +	unsigned nr_pages, crypto_page_idx;
> +	void *crypt_buf = NULL;
>  
>  	hib_init_batch(&hb);
>  
> @@ -1069,18 +1171,42 @@ static int load_image(struct swap_map_handle *handle,
>  	if (!m)
>  		m = 1;
>  	nr_pages = 0;
> +	crypto_page_idx = 0;
> +	if (handle->crypto) {
> +		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
> +		if (!crypt_buf)
> +			return -ENOMEM;
> +	}
>  	start = ktime_get();
>  	for ( ; ; ) {
>  		ret = snapshot_write_next(snapshot);
>  		if (ret <= 0)
>  			break;
> -		ret = swap_read_page(handle, data_of(*snapshot), &hb);
> +		if (handle->crypto)
> +			ret = swap_read_page(handle, crypt_buf, &hb);
> +		else
> +			ret = swap_read_page(handle, data_of(*snapshot), &hb);
>  		if (ret)
>  			break;
>  		if (snapshot->sync_read)
>  			ret = hib_wait_io(&hb);
>  		if (ret)
>  			break;
> +		if (handle->crypto) {
> +			/*
> +			 * Need a decryption for the
> +			 * data read from the block
> +			 * device.
> +			 */
> +			ret = crypto_data(crypt_buf, PAGE_SIZE,
> +					  data_of(*snapshot),
> +					  PAGE_SIZE,
> +					  false,
> +					  crypto_page_idx);
> +			if (ret)
> +				break;
> +			crypto_page_idx++;
> +		}
>  		if (!(nr_pages % m))
>  			pr_info("Image loading progress: %3d%%\n",
>  				nr_pages / m * 10);
> @@ -1097,6 +1223,8 @@ static int load_image(struct swap_map_handle *handle,
>  			ret = -ENODATA;
>  	}
>  	swsusp_show_speed(start, stop, nr_to_read, "Read");
> +	if (crypt_buf)
> +		free_page((unsigned long)crypt_buf);
>  	return ret;
>  }
>  
> @@ -1164,7 +1292,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  	struct hib_bio_batch hb;
>  	ktime_t start;
>  	ktime_t stop;
> -	unsigned nr_pages;
> +	unsigned nr_pages, crypto_page_idx;
>  	size_t off;
>  	unsigned i, thr, run_threads, nr_threads;
>  	unsigned ring = 0, pg = 0, ring_size = 0,
> @@ -1173,6 +1301,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  	unsigned char **page = NULL;
>  	struct dec_data *data = NULL;
>  	struct crc_data *crc = NULL;
> +	void *first_page = NULL;
>  
>  	hib_init_batch(&hb);
>  
> @@ -1278,6 +1407,18 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  	}
>  	want = ring_size = i;
>  
> +	/*
> +	 * The first page of data[thr] contains the length of
> +	 * compressed data, this page should not mess up the
> +	 * read buffer, so we allocate a separate page for it.
> +	 */
> +	if (handle->crypto) {
> +		first_page = (void *)get_zeroed_page(GFP_KERNEL);
> +		if (!first_page) {
> +			ret = -ENOMEM;
> +			goto out_clean;
> +		}
> +	}
>  	pr_info("Using %u thread(s) for decompression\n", nr_threads);
>  	pr_info("Loading and decompressing image data (%u pages)...\n",
>  		nr_to_read);
> @@ -1285,6 +1426,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  	if (!m)
>  		m = 1;
>  	nr_pages = 0;
> +	crypto_page_idx = 0;
>  	start = ktime_get();
>  
>  	ret = snapshot_write_next(snapshot);
> @@ -1336,7 +1478,24 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  		}
>  
>  		for (thr = 0; have && thr < nr_threads; thr++) {
> -			data[thr].cmp_len = *(size_t *)page[pg];
> +			if (handle->crypto) {
> +				/*
> +				 * Need to decrypt the first page
> +				 * of each data[thr], which contains
> +				 * the compressed data length.
> +				 */
> +				ret = crypto_data(page[pg],
> +						  PAGE_SIZE,
> +						  first_page,
> +						  PAGE_SIZE,
> +						  false,
> +						  crypto_page_idx);
> +				if (ret)
> +					goto out_finish;
> +				data[thr].cmp_len = *(size_t *)first_page;
> +			} else {
> +				data[thr].cmp_len = *(size_t *)page[pg];
> +			}
>  			if (unlikely(!data[thr].cmp_len ||
>  			             data[thr].cmp_len >
>  			             lzo1x_worst_compress(LZO_UNC_SIZE))) {
> @@ -1358,8 +1517,26 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  			for (off = 0;
>  			     off < LZO_HEADER + data[thr].cmp_len;
>  			     off += PAGE_SIZE) {
> -				memcpy(data[thr].cmp + off,
> -				       page[pg], PAGE_SIZE);
> +				if (handle->crypto) {
> +					/*
> +					 * Decrypt the compressed data
> +					 * and leverage the decompression
> +					 * threads to get it done.
> +					 */
> +					ret = crypto_data(page[pg],
> +							  PAGE_SIZE,
> +							  data[thr].cmp + off,
> +							  PAGE_SIZE,
> +							  false,
> +							  crypto_page_idx);
> +					if (ret)
> +						goto out_finish;
> +					crypto_page_idx++;
> +				} else {
> +					memcpy(data[thr].cmp + off,
> +						page[pg], PAGE_SIZE);
> +
> +				}
>  				have--;
>  				want++;
>  				if (++pg >= ring_size)
> @@ -1452,6 +1629,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
>  out_clean:
>  	for (i = 0; i < ring_size; i++)
>  		free_page((unsigned long)page[i]);
> +	if (first_page)
> +		free_page((unsigned long)first_page);
>  	if (crc) {
>  		if (crc->thr)
>  			kthread_stop(crc->thr);
> @@ -1482,6 +1661,7 @@ int swsusp_read(unsigned int *flags_p)
>  	struct swsusp_info *header;
>  
>  	memset(&snapshot, 0, sizeof(struct snapshot_handle));
> +	memset(&handle, 0, sizeof(struct swap_map_handle));
>  	error = snapshot_write_next(&snapshot);
>  	if (error < PAGE_SIZE)
>  		return error < 0 ? error : -EFAULT;
> @@ -1489,6 +1669,16 @@ int swsusp_read(unsigned int *flags_p)
>  	error = get_swap_reader(&handle, flags_p);
>  	if (error)
>  		goto end;
> +	if (*flags_p & SF_ENCRYPT_MODE) {
> +		error = crypto_init(false);
> +		if (!error) {
> +			/* The image has been encrypted. */
> +			handle.crypto = true;
> +		} else {
> +			pr_err("Failed to init cipher during resume.\n");
> +			goto end;
> +		}
> +	}
>  	if (!error)
>  		error = swap_read_page(&handle, header, NULL);
>  	if (!error) {
> @@ -1526,6 +1716,9 @@ int swsusp_check(void)
>  
>  		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
>  			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
> +			/* Read salt passed from previous kernel. */
> +			if (swsusp_header->flags & SF_ENCRYPT_MODE)
> +				crypto_restore((void *)&swsusp_header->salt);
>  			/* Reset swap signature now */
>  			error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
>  						swsusp_resume_block,
> -- 
> 2.7.4
> 
