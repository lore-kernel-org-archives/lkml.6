Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AH8x226Mrxm2c8cOesx55vicYHjPjuEmv9qVTaJyJVo3JxmcyQ0pxqVSrkp14bgndlw3u1Fu/aZg
ARC-Seal: i=1; a=rsa-sha256; t=1519324909; cv=none;
        d=google.com; s=arc-20160816;
        b=Ekv8vanlHenrdhGmE9mSdptZToRo5u1CBcTY/r9WwAbbt6isG4Pl2pcGo43TIQrVWF
         qpt8udr1AdaAJh2NAhnVrHQSTbJcMMpE5d+LZdBtl3cT7pwYoy4LGR6rvOqzEj1N5OCU
         paKCSIQpRw+5vec8y1tnYZFZYTe+qgn9XFEH7eQ11VkwopzyOsQ3339dwRfLZpVMe+f9
         uLGIsCf6l/Cw6FY7NAM6SRMhekFLoBUBwJgE+5fIBAMMhzgp4mzm8TF/vuhWhr4TzYPt
         Qv0ttBEtqKMDc4Ra6un5yjwzOI9In1mRE9aCqt3ZcPj4j4qXtiMUZWYt6HUjv1Ed3sme
         9aWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=qEeathUihXrPLUzx9JoS3OBghTWMpulo84j/VJ8rujI=;
        b=nSHGQfImw9twSsCPRNxJKPxDS3g/3fkPJa9+jq1b8DSBpNRH0QMbvR72zkvf9SqFOF
         hxHs+eHcIwgquI5S0ucCWDHR+Lw+H9Vu25qIpgvyaqQ4PUBoLT2pU0+Gqrylwo9vWOtv
         E13zGJ9UpuR0iRslQ+DqCMuQ6f0g5bkDUcUJ7tk+bNMTiNOsfbJ7/ghNp58EsyAE5oay
         vhC7ocVcll6TFkBaZi5c7OxKEqxd+Eih1qfI51Ker9czfQHCQlj1vukT3XB18YaTG07E
         cN4+I+0rl+fiQVV7OyPVeehRyAXyV/77Dw9vgg0wQKgJ4uNZ2R1U64qwKBkUwpMP8v6X
         jccQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.189 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.189 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@infradead.org>, Oza Pawandeep
	<poza@codeaurora.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Kate Stewart
	<kstewart@linuxfoundation.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongdong Liu <liudongdong3@huawei.com>,
	"Keith Busch" <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
	<okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: RE: [PATCH v10 2/7] PCI/AER: factor out error reporting from AER
Thread-Topic: [PATCH v10 2/7] PCI/AER: factor out error reporting from AER
Thread-Index: AQHTrAv2aSA2mzKwCE6vohCF40aW/6OwwPCA
Date: Thu, 22 Feb 2018 18:42:32 +0000
Message-ID: <0cd107dfe3ec4dda89457b112e8f79e5@AcuMS.aculab.com>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-3-git-send-email-poza@codeaurora.org>
 <20180222183448.GB6267@infradead.org>
In-Reply-To: <20180222183448.GB6267@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086410511514158?=
X-GMAIL-MSGID: =?utf-8?q?1593127635616119803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christoph Hellwig
> > -	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> > -	/* TODO: Should kernel panic here? */
> > -	pci_info(dev, "AER: Device recovery failed\n");
> > -}
> > +EXPORT_SYMBOL(pci_find_aer_service);
>=20
> EXPORT_SYMBPOL_GPL please.

Is this a function that a 'normal' PCIe device driver would need to call?
If so it is a PITA requiring all drivers that want AER to be GPL.

	David
